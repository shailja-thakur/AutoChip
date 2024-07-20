module top_module (
    input a,
    input b, 
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire and_cd, not_a, not_b, or_notabc, pos0, pos1;

    // SOP (Sum-of-Products) expression
    assign and_cd = c & d;
    assign not_a = ~a;
    assign not_b = ~b;
    assign or_notabc = (not_a & not_b & c) | and_cd;
    assign out_sop = or_notabc;

    // POS (Product-of-Sums) expression
    assign pos0 = (c & (not_b | d) & (not_a | b));
    assign pos1 = (c & (not_a | d) & (not_b | b));
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
