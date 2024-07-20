module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	reg Y2_reg, Y4_reg;
	
	always @(y or w)
	begin
		if (w == 1'b0) // reset
		begin
			Y2_reg <= 1'b0;
			Y4_reg <= 1'b0;
		end
		else // next-state logic
		begin
			case (y)
				6'b000001: // State A
				begin
					Y2_reg <= 1'b0; // Y2 doesn't change
					Y4_reg <= 1'b1; // Y4 transitions to 1 in next state
				end
				
				6'b000010: // State B
				begin
					Y2_reg <= 1'b0; // Y2 doesn't change
					Y4_reg <= 1'b0; // Y4 transitions to 0 in next state
				end
				
				6'b000100: // State C
				begin
					Y2_reg <= 1'b0; // Y2 doesn't change
					Y4_reg <= 1'b1; // Y4 transitions to 1 in next state
				end
				
				6'b001000: // State D
				begin
					Y2_reg <= 1'b0; // Y2 doesn't change
					Y4_reg <= 1'b0; // Y4 transitions to 0 in next state
				end
				
				6'b010000: // State E
				begin
					Y2_reg <= 1'b1; // Y2 transitions to 1 in next state
					Y4_reg <= 1'b0; // Y4 doesn't change
				end
				
				6'b100000: // State F
				begin
					Y2_reg <= 1'b0; // Y2 doesn't change
					Y4_reg <= 1'b0; // Y4 transitions to 0 in next state
				end
			endcase
		end
	end
	
	assign Y2 = Y2_reg;
	assign Y4 = Y4_reg;
endmodule
