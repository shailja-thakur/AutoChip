module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Bitwise OR of the two input vectors
	assign out_or_bitwise = a | b;

	// Logical OR of the two input vectors
	assign out_or_logical = (a != 0) || (b != 0);

	// Complement of input vector b in the upper half of out_not (bits [5:3])
	assign out_not[5:3] = ~b;

	// Complement of input vector a in the lower half of out_not (bits [2:0])
	assign out_not[2:0] = ~a;

endmodule
