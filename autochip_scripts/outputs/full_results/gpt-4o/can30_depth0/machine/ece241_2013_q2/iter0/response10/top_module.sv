module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP Expression: (c & d) | (~a & ~b & c)
    assign out_sop = (c & d) | (~a & ~b & c);

    // Intermediate wires for POS expression
    wire pos0, pos1;

    // POS Expression: 
    // pos0 = c & (~b | d) & (~a | b)
    // pos1 = c & (~b | d) & (~a | d)
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);

    // Ternary expression to determine out_pos
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
