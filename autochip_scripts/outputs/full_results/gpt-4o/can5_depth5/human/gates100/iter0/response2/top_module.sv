module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

    assign out_and = &in;       // AND reduction operator applied to the input vector
    assign out_or = |in;        // OR reduction operator applied to the input vector
    assign out_xor = ^in;       // XOR reduction operator applied to the input vector

endmodule
