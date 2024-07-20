module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte_1, byte_2, byte_3;
	reg [2:0] state;
	reg done_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			done_reg <= 0;
			byte_1 <= 0;
			byte_2 <= 0;
			byte_3 <= 0;
		end else begin
			case (state)
				0: begin
					if (in[3]) begin
						state <= 1;
						byte_1 <= in;
					end
				end
				1: begin
					state <= 2;
					byte_2 <= in;
				end
				2: begin
					state <= 3;
					byte_3 <= in;
					done_reg <= 1;
				end
				3: begin
					state <= 0;
					done_reg <= 0;
					byte_1 <= 0;
					byte_2 <= 0;
					byte_3 <= 0;
				end
			endcase
		end
	end

	assign out_bytes = {byte_1, byte_2, byte_3};
	assign done = done_reg;

endmodule
