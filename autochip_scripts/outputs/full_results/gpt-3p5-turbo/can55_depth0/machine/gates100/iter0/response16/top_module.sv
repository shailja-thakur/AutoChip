module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

	// Perform logical AND operation
	assign out_and = &in;

	// Perform logical OR operation
	assign out_or = |in;

	// Perform logical XOR operation
	assign out_xor = ^in;

endmodule
