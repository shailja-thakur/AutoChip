module top_module(
	input [2:0] a,
	input [2:0] b,
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// bitwise-OR of a and b
	assign out_or_bitwise = a | b;

	// logical-OR of a and b
	assign out_or_logical = |(a | b);

	// inverse (NOT) of a and b
	assign out_not = {~b, ~a};

endmodule
