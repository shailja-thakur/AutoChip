module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire sop_and, sop_or, pos0, pos1;

    // out_sop = c & d + ~a & ~b & c
    assign sop_and = c & d;
    assign sop_or = sop_and | (~a & ~b & c);
    assign out_sop = sop_or;

    // out_pos = (c & ~b | d) & (c & ~a | b)
    assign pos0 = (c & (~b | d)) & (c & (~a | b));
    assign pos1 = (c & (~a | d)) & (c & (~b | b));
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
