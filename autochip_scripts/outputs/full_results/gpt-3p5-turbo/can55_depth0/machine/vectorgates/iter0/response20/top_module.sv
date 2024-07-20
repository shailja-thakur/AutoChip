module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Output port for bitwise OR
	assign out_or_bitwise = a | b;

	// Output port for logical OR
	assign out_or_logical = (a | b) == 0 ? 0 : 1;

	// Output port for bitwise NOT
	assign out_not = ~{b, a};

endmodule
