module top_module (
	input [99:0] in,
	output reg out_and,
	output reg out_or,
	output reg out_xor
);

	// Perform AND operation
	assign out_and = &in;

	// Perform OR operation
	assign out_or = |in;

	// Perform XOR operation
	assign out_xor = ^in;

endmodule
