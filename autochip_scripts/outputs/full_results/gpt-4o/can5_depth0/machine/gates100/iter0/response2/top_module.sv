module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

    // Initial values for the reduction operation
    assign out_and = &in;  // The reduction AND operator
    assign out_or = |in;   // The reduction OR operator
    assign out_xor = ^in;  // The reduction XOR operator

endmodule
