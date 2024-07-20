module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    wire sop_and1, sop_and2;
    wire pos0, pos1;

    // SOP: Sum-of-Products
    assign sop_and1 = c & d;
    assign sop_and2 = (~a) & (~b) & c;
    assign out_sop = sop_and1 | sop_and2;

    // POS: Product-of-Sums
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~a) | d);

    // Tie the final POS expression to out_pos
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
