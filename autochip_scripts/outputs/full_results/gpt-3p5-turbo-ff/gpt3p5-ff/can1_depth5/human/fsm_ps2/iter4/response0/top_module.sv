module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);
	reg [2:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			done <= 0;
		end else begin
			case (state)
				0: begin
					if (in[3] == 1)
						state <= 1;
					else
						state <= 0;
				end
				1: begin
					if (in[3] == 1)
						state <= 2;
					else
						state <= 0;
				end
				2: begin
					if (in[3] == 1)
						state <= 3;
					else
						state <= 0;
				end
				3: begin
					done <= 1;
					state <= 0;
				end
			endcase
		end
	end
endmodule
