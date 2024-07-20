module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Assign the out_or_bitwise output port to the bitwise OR of a and b
	assign out_or_bitwise = a | b;

	// Assign the out_or_logical output port to the logical OR of a and b
	assign out_or_logical = a || b;

	// Assign the out_not output port to the bitwise NOT of a and b, in reverse order
	assign out_not = ~{a, b};

endmodule
