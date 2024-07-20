module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

    // AND gate
    assign out_and = &in; // Bitwise AND reduction

    // OR gate
    assign out_or = |in; // Bitwise OR reduction

    // XOR gate
    assign out_xor = ^in; // Bitwise XOR reduction

endmodule
