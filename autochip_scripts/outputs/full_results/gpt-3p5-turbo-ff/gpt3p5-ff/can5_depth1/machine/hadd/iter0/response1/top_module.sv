module top_module (
	// Declare the inputs and outputs
	input a,
	input b,
	output sum,
	output cout
);

	// Assign the outputs to the result of the addition
	assign {sum, cout} = a + b;

endmodule
