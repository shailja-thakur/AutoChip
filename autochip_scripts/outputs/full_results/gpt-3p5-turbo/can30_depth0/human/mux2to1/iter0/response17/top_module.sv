module top_module (
	input a,
	input b,
	input sel,
	output out
);

	/*
		You can use the ternary operator to implement the 2-to-1 multiplexer.
		The ternary operator has the syntax:
			condition ? true_expression : false_expression;
	*/
	assign out = sel ? b : a;

endmodule
