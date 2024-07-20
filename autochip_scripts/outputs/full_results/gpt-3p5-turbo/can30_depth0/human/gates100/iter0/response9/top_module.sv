module top_module (
	input [99:0] in,
	output reg out_and, // Using "reg" to store the output values
	output reg out_or,
	output reg out_xor
);

	// AND gate
	assign out_and = &in;

	// OR gate
	assign out_or = |in;

	// XOR gate
	assign out_xor = ^in;

endmodule
