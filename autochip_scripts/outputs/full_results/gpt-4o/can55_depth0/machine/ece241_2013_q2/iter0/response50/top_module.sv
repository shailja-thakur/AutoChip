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
    wire and_c_or_notbd, or_notad, and_result0, and_result1;

    // Generate intermediate signals
    assign not_a = ~a;
    assign not_b = ~b;

    // SOP expression for out_sop
    assign and_cd = c & d;
    assign and_notab_c = not_a & not_b & c;
    assign out_sop = and_cd | and_notab_c;

    // POS expression
    assign and_c_or_notbd = c & (not_b | d);
    assign or_notad = not_a | d;
    assign and_result0 = and_c_or_notbd & (not_a | b);
    assign and_result1 = and_c_or_notbd & or_notad;
    
    assign out_pos = (and_result0 == and_result1) ? and_result0 : 1'bx;

endmodule
