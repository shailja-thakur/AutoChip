module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate SOP expression
    assign out_sop = (c & d) | (~a & ~b & c);

    // Generate POS expression
    wire pos0, pos1;
    assign pos0 = (c & ~b | c & d);
    assign pos1 = (c & ~a | c & d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
