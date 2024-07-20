module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate SOP output
    assign out_sop = (c & d) | (~a & ~b & c);

    // Generate intermediate POS results
    wire pos0, pos1;
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~b) | d) & ((~a) | d);

    // Generate POS output with ternary expression
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
