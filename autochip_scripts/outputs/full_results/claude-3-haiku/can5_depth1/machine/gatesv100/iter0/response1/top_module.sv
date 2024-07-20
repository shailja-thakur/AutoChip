module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Generate out_both
    assign out_both = in & (in >> 1);

    // Generate out_any
    assign out_any = in;

    // Generate out_different
    assign out_different[99:1] = in ^ (in >> 1);
    assign out_different[0] = in[99] ^ in[0];

endmodule
