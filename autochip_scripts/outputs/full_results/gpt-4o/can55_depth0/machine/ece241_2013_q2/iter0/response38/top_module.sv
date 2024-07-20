module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    // Intermediate signals
    wire and1, and2, not_a, not_b, or1;
    wire pos0, pos1;

    // Calculating intermediate signals for SOP expression
    assign not_a = ~a;
    assign not_b = ~b;
    assign and1 = c & d;
    assign and2 = not_a & not_b & c;
    assign out_sop = and1 | and2;

    // Calculating intermediate signals for POS expression
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_b | d) & (not_a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
