module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		out_bytes <= 0;
		done <= 0;
	end else begin
		case (state)
			2'b00: begin // BYTE1
				if (in[2] == 1'b1)
					state <= 2'b01; // BYTE2
				else
					state <= 2'b00; // BYTE1
			end

			2'b01: begin // BYTE2
				if (in[2] == 1'b1)
					state <= 2'b10; // BYTE3
				else
					state <= 2'b00; // BYTE1
			end

			2'b10: begin // BYTE3
				state <= 2'b11; // DONE
			end

			2'b11: begin // DONE
				if (in[2] == 1'b0)
					state <= 2'b00; // BYTE1
				else
					state <= 2'b11; // DONE
			end
		endcase
	end
end

always @(posedge clk) begin
	if (done)
		out_bytes <= out_bytes << 8 | in;
end

always @(posedge clk or posedge reset) begin
	if (reset)
		done <= 0;
	else if (state == 2'b11)
		done <= 1;
end

endmodule
