module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	// Intermediate wires for reduction operations
	wire reduction_and;
	wire reduction_or;
	wire reduction_xor;

	// Reduction operations
	assign reduction_and = &in; // AND reduction
	assign reduction_or = |in;  // OR reduction
	assign reduction_xor = ^in; // XOR reduction

	// Assign the reductions to the output ports
	assign out_and = reduction_and;
	assign out_or = reduction_or;
	assign out_xor = reduction_xor;

endmodule
