module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Wire declaration
	wire [1:0] sum_wire;
	wire cout_wire;

	// Adder implementation
	assign {cout_wire, sum_wire} = a + b;

	// Output assignment
	assign sum = sum_wire;
	assign cout = cout_wire;

endmodule
