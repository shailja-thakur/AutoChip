module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_reg;
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_reg <= 0;
			state <= 0;
		end else begin
			case (state)
				0: begin
					if (in[2]) begin
						out_reg <= {out_reg[15:0], in};
						state <= 1;
					end else begin
						out_reg <= {out_reg[15:0], in};
						state <= 0;
					end
				end
				1: begin
					out_reg <= {out_reg[15:0], in};
					state <= 2;
				end
				2: begin
					out_reg <= {out_reg[15:0], in};
					state <= 3;
				end
				3: begin
					out_reg <= {out_reg[15:0], in};
					state <= 4;
				end
				4: begin
					out_reg <= {out_reg[15:0], in};
					state <= 0;
					if (in[2])
						state <= 1;
				end
				default: state <= 0;
			endcase

			done <= (state == 4);
		end
	end

	assign out_bytes = (done) ? out_reg : 0;

endmodule
