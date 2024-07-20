module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_reg;
	reg [2:0] state;

	always @(posedge clk)
	begin
		if (reset)
		begin
			out_reg <= 0;
			state <= 0;
		end
		else
		begin
			case(state)
				0:
				begin
					if (in[2] == 1)
						state <= 1;
					else
						state <= 0;
				end
				
				1:
				begin
					if (in[2] == 1)
						state <= 2;
					else
						state <= 0;
				end
				
				2:
				begin
					if (in[2] == 1)
						state <= 3;
					else
						state <= 0;
				end
				
				3:
				begin
					state <= 0;
				end
			endcase
		end

		if(state == 3)
		begin
			out_reg <= {out_reg[15:0], in};
			out_bytes <= out_reg;
		end
		else
		begin
			out_bytes <= out_reg;
		end
	end

	assign done = (state == 3);

endmodule
