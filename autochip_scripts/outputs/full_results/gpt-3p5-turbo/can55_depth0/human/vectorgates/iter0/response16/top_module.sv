module top_module(
	input [2:0] a,
	input [2:0] b,
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Wire declarations
	wire [2:0] a_inv;
	wire [2:0] b_inv;

	// Bitwise-OR of a and b
	assign out_or_bitwise = a | b;

	// Logical-OR of a and b
	assign out_or_logical = a || b;

	// Inverse of a
	assign a_inv = ~a;

	// Inverse of b
	assign b_inv = ~b;

	// Combining the inverses to form out_not
	assign out_not = {b_inv, a_inv};

endmodule
