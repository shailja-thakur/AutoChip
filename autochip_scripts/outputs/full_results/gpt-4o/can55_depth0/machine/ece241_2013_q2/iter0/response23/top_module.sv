module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire not_a, not_b;
    wire and_cd, and_notab_c, sop_intermediate;

    // Generate not_a and not_b
    assign not_a = ~a;
    assign not_b = ~b;

    // Generate the intermediate wires for SOP expression
    assign and_cd = c & d;
    assign and_notab_c = not_a & not_b & c;

    // Generate the out_sop output
    assign sop_intermediate = and_cd | and_notab_c;
    assign out_sop = sop_intermediate;

    wire pos0, pos1;
    wire or_notb_d, or_nota_b, or_nota_d;

    // Generate intermediate wires for POS expression
    assign or_notb_d = not_b | d;
    assign or_nota_b = not_a | b;
    assign or_nota_d = not_a | d;

    // Generate pos0 and pos1 intermediate values
    assign pos0 = c & or_notb_d & or_nota_b;
    assign pos1 = c & or_notb_d & or_nota_d;

    // Generate the out_pos output
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
