module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP expression for out_sop
    assign out_sop = (c & d) | (~a & ~b & c);

    // Intermediate signals for POS
    wire pos0, pos1;

    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);

    // POS expression for out_pos
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx; // If both pos0 and pos1 are equal, assign out_pos to pos0, otherwise assign 1'bx (unknown)

endmodule
