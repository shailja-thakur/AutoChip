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
    wire or1;

    wire pos0, pos1;

    // Generate the negations
    assign not_a = ~a;
    assign not_b = ~b;

    // Generate the SOP output
    assign and_cd = c & d;
    assign and_notab_c = not_a & not_b & c;
    assign out_sop = and_cd | and_notab_c;

    // Generate the POS intermediate signals
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_b | d) & (not_a | d);

    // Generate the POS output
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
