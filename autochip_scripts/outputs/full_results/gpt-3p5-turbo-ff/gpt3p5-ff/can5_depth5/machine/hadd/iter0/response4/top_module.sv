module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wire for carry out
	wire cin;

	// Perform addition and generate sum and carry out
	assign {cout, sum} = a + b + cin;

endmodule
