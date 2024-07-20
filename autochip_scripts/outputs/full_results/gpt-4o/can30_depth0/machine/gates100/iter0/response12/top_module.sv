module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Intermediate signals to hold the reduction results
	wire and_result;
	wire or_result;
	wire xor_result;

	// Perform reduction operations
	assign and_result = &in; // AND reduction
	assign or_result = |in;  // OR reduction
	assign xor_result = ^in; // XOR reduction
	
	// Assign the results to the output ports
	assign out_and = and_result;
	assign out_or = or_result;
	assign out_xor = xor_result;

endmodule
