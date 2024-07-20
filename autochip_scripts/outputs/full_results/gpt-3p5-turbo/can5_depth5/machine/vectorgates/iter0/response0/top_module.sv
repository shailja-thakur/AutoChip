module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Assign out_or_bitwise to the bitwise OR of a and b
	assign out_or_bitwise = a | b;

	// Assign out_or_logical to the logical OR of a and b
	assign out_or_logical = (a != 0) || (b != 0);

	// Assign out_not to the bitwise NOT of a and b, in reverse order
	assign out_not = {~b, ~a};

endmodule
