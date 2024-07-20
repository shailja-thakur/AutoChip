module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	assign out_or_bitwise = a | b; // Bitwise OR
	assign out_or_logical = |(a | b); // Logical OR of the result of bitwise OR
	assign out_not = {~b, ~a}; // Inverse of b in upper half, inverse of a in lower half

endmodule
