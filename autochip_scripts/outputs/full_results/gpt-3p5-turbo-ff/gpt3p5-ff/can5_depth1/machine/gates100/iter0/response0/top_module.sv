module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Intermediate wire to store the logical AND result
	wire and_result;
	// Intermediate wire to store the logical OR result
	wire or_result;
	// Intermediate wire to store the logical XOR result
	wire xor_result;

	// Perform the logical AND operation
	assign and_result = &in;

	// Perform the logical OR operation
	assign or_result = |in;

	// Perform the logical XOR operation
	assign xor_result = ^in;

	// Assign the intermediate results to the output ports
	assign out_and = and_result;
	assign out_or = or_result;
	assign out_xor = xor_result;

endmodule
