module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
    assign out_and = &in; // Perform logical AND on all bits of the input vector
    assign out_or = |in;  // Perform logical OR on all bits of the input vector
    assign out_xor = ^in; // Perform logical XOR on all bits of the input vector

endmodule
