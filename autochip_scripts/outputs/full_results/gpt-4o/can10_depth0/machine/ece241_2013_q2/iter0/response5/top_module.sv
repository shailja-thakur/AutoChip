module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP expression
    assign out_sop = (c & d) | (~a & ~b & c);

    // Intermediate wires for POS expression
    wire pos0, pos1;

    assign pos0 = c & ((~b | d) & (~a | b));
    assign pos1 = c & ((~b | d) & (~a | d));

    // Ternary operation to select out_pos
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
