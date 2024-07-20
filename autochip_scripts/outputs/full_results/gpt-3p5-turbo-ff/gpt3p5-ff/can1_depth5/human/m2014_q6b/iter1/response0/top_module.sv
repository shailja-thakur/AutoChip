module top_module(
	input [3:1] y,
	input w,
	output reg Y2);
	
	always @(*) begin
		case(y)
			3'b000: begin
				if(w)
					Y2 = 1;
				else
					Y2 = 0;
			end
			3'b001: begin
				if(w)
					Y2 = 0;
				else
					Y2 = 1;
			end
			3'b010: Y2 = 0;
			3'b011: Y2 = 1;
			3'b100: Y2 = 0;
			3'b101: Y2 = 1;
		endcase
	end
	
	// Add default case for unhandled states
	always @(y) begin
		if(y != 3'b000 && y != 3'b001 && y != 3'b010 && y != 3'b011 && y != 3'b100 && y != 3'b101)
			Y2 = 0;
	end
endmodule
