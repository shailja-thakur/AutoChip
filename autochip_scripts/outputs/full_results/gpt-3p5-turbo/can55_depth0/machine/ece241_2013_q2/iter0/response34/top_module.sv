module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    wire pos0, pos1;

    // Generate out_sop
    assign out_sop = (c & d) | ((!a & !b & c));

    // Generate pos0
    assign pos0 = c & ((!b & d) | (!a & b));

    // Generate pos1
    assign pos1 = c & (!a & d);

    // Generate out_pos using ternary expression
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
