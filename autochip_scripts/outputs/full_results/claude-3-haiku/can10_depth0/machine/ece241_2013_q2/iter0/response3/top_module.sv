module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire sop;
    wire pos0, pos1;

    // out_sop (SOP expression)
    assign sop = (c & d) | (~a & ~b & c);
    assign out_sop = sop;

    // out_pos (POS expression)
    assign pos0 = (c & (~b | d) & (~a | b));
    assign pos1 = (c & (~a | d));
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
