module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;
wire done_next;

assign done_next = (state == 2) ? 1'b1 : 1'b0;

always @(posedge clk) begin
	if (reset) begin
		byte1 <= 8'b0;
		byte2 <= 8'b0;
		byte3 <= 8'b0;
		state <= 2'b00;
	end else begin
		case (state)
			2'b00: begin
				if (in[3] == 1'b1) begin
					byte1 <= in;
					state <= 2'b01;
				end
			end
			2'b01: begin
				byte2 <= in;
				state <= 2'b10;
			end
			2'b10: begin
				byte3 <= in;
				state <= 2'b00;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (reset) begin
		out_bytes <= 24'b0;
		done <= 1'b0;
	end else begin
		if (done_next) begin
			out_bytes <= {byte1, byte2, byte3};
			done <= 1'b1;
		end else begin
			done <= 1'b0;
		end
	end
end

endmodule
