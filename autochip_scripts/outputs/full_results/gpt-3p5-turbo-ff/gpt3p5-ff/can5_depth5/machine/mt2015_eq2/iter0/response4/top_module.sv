module top_module(
	input [1:0] A,
	input [1:0] B,
	output z);

	// Declare signal wires for each bit comparison
	wire bit0_eq, bit1_eq;

	// Compare each bit of A and B
	assign bit0_eq = (A[0] == B[0]);
	assign bit1_eq = (A[1] == B[1]);

	// Output z is only 1 if all bits are equal
	assign z = (bit0_eq && bit1_eq);

endmodule
