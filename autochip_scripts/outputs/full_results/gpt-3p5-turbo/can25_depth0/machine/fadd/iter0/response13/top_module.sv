module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// internal wire declaration
	wire cout;
	wire sum;

	// adder logic
	assign {cout, sum} = a + b + cin;

endmodule
