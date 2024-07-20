module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire intermediate_sop1;
    wire intermediate_sop2;
    wire intermediate_pos1;
    wire intermediate_pos2;
    wire pos0;
    wire pos1;

    // SOP Expression: out_sop = (c & d) | (~a & ~b & c)
    assign intermediate_sop1 = c & d;
    assign intermediate_sop2 = ~a & ~b & c;
    assign out_sop = intermediate_sop1 | intermediate_sop2;

    // POS Expression
    // pos0 = c & (~b | d) & (~a | b)
    // pos1 = c & (~b | d) & (~a | d)
    assign intermediate_pos1 = ~b | d;
    assign intermediate_pos2 = ~a | b;
    assign pos0 = c & intermediate_pos1 & intermediate_pos2;

    assign intermediate_pos2 = ~a | d;
    assign pos1 = c & intermediate_pos1 & intermediate_pos2;

    // out_pos = (pos0 == pos1) ? pos0 : 1'bx
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
