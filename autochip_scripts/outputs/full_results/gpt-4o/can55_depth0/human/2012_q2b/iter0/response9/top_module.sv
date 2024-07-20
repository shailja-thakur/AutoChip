module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// States representation
	parameter S_A = 6'b000001;
	parameter S_B = 6'b000010;
	parameter S_C = 6'b000100;
	parameter S_D = 6'b001000;
	parameter S_E = 6'b010000;
	parameter S_F = 6'b100000;

	// Next state logic for Y1 (state B)
	assign Y1 = (y == S_A && w == 1) ? 1 :
	            (y == S_B && w == 0) ? 1 :
	            0;

	// Next state logic for Y3 (state D)
	assign Y3 = (y == S_B && w == 0) ? 1 :
	            (y == S_C && w == 0) ? 1 :
	            (y == S_D && w == 0) ? 1 :
	            (y == S_E && w == 0) ? 1 :
	            (y == S_F && w == 0) ? 1 :
	            0;
endmodule
