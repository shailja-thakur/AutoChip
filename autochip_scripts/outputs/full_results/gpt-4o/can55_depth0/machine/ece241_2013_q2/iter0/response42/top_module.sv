module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire and_cd;
    wire and_not_a_not_b_c;
    wire or_sop;

    wire not_a;
    wire not_b;

    wire and_c_or_not_b_d;
    wire and_c_or_not_a_b;
    wire pos0;

    wire and_c_or_not_a_d;
    wire pos1;

    assign not_a = ~a;
    assign not_b = ~b;

    // SOP Logic
    assign and_cd = c & d;
    assign and_not_a_not_b_c = not_a & not_b & c;
    assign or_sop = and_cd | and_not_a_not_b_c;
    assign out_sop = or_sop;

    // POS Logic
    assign and_c_or_not_b_d = c & (not_b | d);
    assign and_c_or_not_a_b = c & (not_a | b);
    assign pos0 = and_c_or_not_b_d & and_c_or_not_a_b;

    assign and_c_or_not_a_d = c & (not_a | d);
    assign pos1 = and_c_or_not_b_d & and_c_or_not_a_d;

    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
