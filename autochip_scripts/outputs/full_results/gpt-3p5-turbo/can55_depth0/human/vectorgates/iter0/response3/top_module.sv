module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Bitwise-OR Logic
	assign out_or_bitwise = a | b;

	// Logical-OR Logic
	assign out_or_logical = (a != 0) || (b != 0);

	// Inverse (NOT) Logic
	assign out_not = ~{~a, ~b};

endmodule
