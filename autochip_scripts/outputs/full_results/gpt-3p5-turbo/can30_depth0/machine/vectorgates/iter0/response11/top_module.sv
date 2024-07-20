module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [2:0] out_not
);

	// Assign the bitwise OR of the two inputs to out_or_bitwise
	assign out_or_bitwise = a | b;

	// Assign the logical OR of the two inputs to out_or_logical
	assign out_or_logical = a || b;

	// Assign the bitwise NOT of the two inputs, in reverse order, to out_not
	assign out_not = ~{b, a};

endmodule
