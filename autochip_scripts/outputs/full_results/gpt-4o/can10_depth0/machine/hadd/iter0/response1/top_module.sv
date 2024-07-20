module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Perform addition and assign to outputs
	assign {cout, sum} = a + b;

endmodule
