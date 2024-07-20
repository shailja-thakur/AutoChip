module top_module(
	input a, 
	input b,
	input c,
	output out
);

    // According to the Karnaugh map, the output (out) should be high (1) for the following minterms:
    // bc\ a
    // 00 | 0 | 1 |
    // 01 | 1 | 1 |
    // 11 | 1 | 1 |
    // 10 | 1 | 1 |
    // The minterms covered are: 001, 011, 111, 101 and 100
    // The simplified boolean expression is: out = b | (~a & c)

    assign out = b | (~a & c);

endmodule
