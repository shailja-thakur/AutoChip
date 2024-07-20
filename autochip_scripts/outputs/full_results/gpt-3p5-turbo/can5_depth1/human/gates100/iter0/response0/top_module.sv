module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	/**
     * AND Gate
     * Perform an AND operation on all the input bits
     */
    assign out_and = &in;

    /**
     * OR Gate
     * Perform an OR operation on all the input bits
     */
    assign out_or = |in;

    /**
     * XOR Gate
     * Perform an XOR operation on all the input bits
     */
    assign out_xor = ^in;

endmodule
