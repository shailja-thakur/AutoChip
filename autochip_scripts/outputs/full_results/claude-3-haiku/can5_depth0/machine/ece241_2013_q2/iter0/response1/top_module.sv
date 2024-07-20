module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate the out_sop output
    assign out_sop = (c & d) | (~a & ~b & c);

    // Generate the out_pos output
    wire pos0 = (c & (~b | d) & (~a | b));
    wire pos1 = (c & (~a | d));
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
