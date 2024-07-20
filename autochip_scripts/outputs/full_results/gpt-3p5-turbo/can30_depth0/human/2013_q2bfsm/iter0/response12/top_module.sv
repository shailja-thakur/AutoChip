module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [1:0] state;
	always @(posedge clk or negedge resetn)
	begin
		if (~resetn)
			state <= 2'b00; // Beginning state A
		else
		begin
			case (state)
				2'b00: // State A
				begin
					f <= 0;
					g <= 0;
					if (resetn)
						state <= 2'b01;
				end
				
				2'b01: // State B
				begin
					f <= 1;
					g <= 0;
					state <= 2'b10;
				end
				
				2'b10: // State C
				begin
					if (x == 1 && $past(x) == 0 && $past($past(x)) == 1)
					begin
						f <= 1;
						state <= 2'b11;
					end
					else
					begin
						f <= 0;
						state <= 2'b10;
					end
				end
				
				2'b11: // State D
				begin
					if (y == 1)
					begin
						g <= 1;
						state <= 2'b11;
					end
					else if (y == 0)
					begin
						g <= 0;
						state <= 2'b11;
					end
					else
						state <= 2'b10;
				end
			endcase
		end
	end
endmodule
