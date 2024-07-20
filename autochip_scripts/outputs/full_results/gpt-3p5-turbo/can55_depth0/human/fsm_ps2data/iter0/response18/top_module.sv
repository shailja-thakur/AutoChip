module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte1, byte2, byte3;
	reg done_reg;
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			done_reg <= 0;
		end else begin
			case (state)
				0: begin
					if (in[3] == 1) begin
						byte1 <= in;
						state <= 1;
					end
				end
				1: begin
					byte2 <= in;
					state <= 2;
				end
				2: begin
					byte3 <= in;
					done_reg <= 1;
					state <= 3;
				end
				3: begin
					done_reg <= 0;
					byte1 <= 0;
					byte2 <= 0;
					byte3 <= 0;
					state <= 0;
				end
			endcase
		end
	end
	
	assign out_bytes = {byte1, byte2, byte3};
	assign done = done_reg;

endmodule
