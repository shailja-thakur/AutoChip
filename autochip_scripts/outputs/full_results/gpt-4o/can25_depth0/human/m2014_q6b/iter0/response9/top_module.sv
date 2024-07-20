module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: Y2 = 0;          // State A, next states are A (y[2]=0) or B (y[2]=0)
			3'b001: if (w)           // State B
			           Y2 = 0;      // Next state D, y[2]=0
				else
			           Y2 = 0;      // Next state C, y[2]=0
			3'b010: if (w)           // State C
			           Y2 = 1;      // Next state D, y[2]=1
				else
			           Y2 = 0;      // Next state E, y[2]=0
			3'b011: if (w)           // State D
			           Y2 = 0;      // Next state A, y[2]=0
				else
			           Y2 = 1;      // Next state F, y[2]=1
			3'b100: Y2 = 1;          // State E, next states are E (y[2]=1) or D (y[2]=1)
			3'b101: if (w)           // State F
			           Y2 = 1;      // Next state D, y[2]=1
				else
			           Y2 = 0;      // Next state C, y[2]=0
			default: Y2 = 0;         // default case
		endcase
	end
	
endmodule
