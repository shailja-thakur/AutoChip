module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
    wire not_a, not_b;
    wire and_cd, and_not_ab_c;
    wire sop_result;

    // Calculate NOT a and NOT b
    assign not_a = ~a;
    assign not_b = ~b;

    // Generate SOP expression
    assign and_cd = c & d;
    assign and_not_ab_c = not_a & not_b & c;
    assign out_sop = and_cd | and_not_ab_c;

    // Generate POS expression
    wire pos0, pos1;
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_b | d) & (not_a | d);

    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
