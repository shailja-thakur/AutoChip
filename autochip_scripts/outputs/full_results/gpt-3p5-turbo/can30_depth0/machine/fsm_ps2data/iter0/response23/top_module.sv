module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);
	reg [1:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			out_bytes <= 0;
			done <= 0;
		end else begin
			case (state)
				0: begin // BYTE1 state
					if (in[2]) // Transition to BYTE2 if third bit of input is 1
						state <= 1;
					else
						state <= 0;
				end
				1: begin // BYTE2 state
					if (in[2]) // Transition to BYTE3 if third bit of input is 1
						state <= 2;
					else
						state <= 0;
				end
				2: begin // BYTE3 state
					state <= 3;
				end
				3: begin // DONE state
					if (in[2]) // Transition back to BYTE1 if third bit of input is 1
						state <= 0;
					else
						state <= 3;
				end
			endcase
			if (state == 3) begin
				done <= 1;
				out_bytes <= in;
			end
			out_bytes <= {out_bytes[15:0], in}; // Shift input into register
		end
	end
endmodule
