module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] register;
reg done;

always @(posedge clk) begin
	if (reset) begin
		state <= BYTE1;
		register <= 0;
		done <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (in[2] == 1'b1) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
			
			BYTE2: begin
				state <= BYTE3;
			end

			BYTE3: begin
				state <= DONE;
			end

			DONE: begin
				if (in[2] == 1'b0) begin
					state <= BYTE1;
				end
			end
		endcase

		if (state == DONE) begin
			done <= 1;
		end else begin
			done <= 0;
		end
	end
end

always @(posedge clk) begin
	if (state != DONE) begin
		register <= {register[15:0], in};
	end
end

assign out_bytes = done ? register : 0;

endmodule
