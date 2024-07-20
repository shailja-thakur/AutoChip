module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    wire not_a, not_b;
    wire and_cd, and_notab_c;
    wire pos0, pos1;

    // Generate the negations
    assign not_a = ~a;
    assign not_b = ~b;

    // SOP: Sum of Products
    assign and_cd = c & d;
    assign and_notab_c = not_a & not_b & c;
    assign out_sop = and_cd | and_notab_c;

    // POS: Product of Sums
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_b | d) & (not_a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
