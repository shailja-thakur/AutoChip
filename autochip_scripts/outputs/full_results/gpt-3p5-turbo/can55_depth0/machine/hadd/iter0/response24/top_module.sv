module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// Adder logic
	assign {cout, sum} = a + b;
endmodule
