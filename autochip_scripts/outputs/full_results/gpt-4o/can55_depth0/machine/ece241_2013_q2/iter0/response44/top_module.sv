module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // out_sop computation
    wire not_a, not_b;
    wire and_cd, and_notab_c;

    assign not_a = ~a;
    assign not_b = ~b;

    assign and_cd = c & d;
    assign and_notab_c = not_a & not_b & c;

    assign out_sop = and_cd | and_notab_c;

    // out_pos computation
    wire pos0, pos1;

    assign pos0 = c & ((~b | d) & (~a | b));
    assign pos1 = c & ((~b | d) & (~a | d));

    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
