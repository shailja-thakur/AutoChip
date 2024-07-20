module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

// logic to calculate AND of all bits in the input vector
assign out_and = &in;

// logic to calculate OR of all bits in the input vector
assign out_or = |in;

// logic to calculate XOR of all bits in the input vector
assign out_xor = ^in;

endmodule
