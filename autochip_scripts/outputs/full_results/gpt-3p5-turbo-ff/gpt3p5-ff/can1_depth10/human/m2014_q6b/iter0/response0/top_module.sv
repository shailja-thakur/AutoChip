module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	// define the states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	// define the next state logic for y[2]
	always @(y or w) begin
		case (y[3:1])
			A: Y2 = (w == 0) ? 0 : 0;
			B: Y2 = (w == 0) ? 0 : 1;
			C: Y2 = (w == 0) ? 1 : 0;
			D: Y2 = (w == 0) ? 1 : 0;
			E: Y2 = (w == 0) ? 1 : 1;
			F: Y2 = (w == 0) ? 0 : 1;
			default: Y2 = 0;
		endcase
	end
endmodule
