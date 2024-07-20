module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    // Sum-of-products form
    assign out_sop = (~a & b & c & d) | (a & b & ~c & ~d) | (a & b & c & d);

    // Product-of-sums form
    assign out_pos = (a | b | ~c | d) & (a | ~b | c | d) & (~a | b | ~c | d);

endmodule
