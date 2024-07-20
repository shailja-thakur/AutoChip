module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Internal wire declarations
	wire [31:0] reversed_in;

	// instantiate the byte reversal circuit
	byte_reversal_module byte_reversal(
		.in(in),
		.out(reversed_in)
	);

	// instantiate the 32-bit reversal circuit
	bit_reversal_module bit_reversal(
		.in(reversed_in),
		.out(out)
	);

endmodule
