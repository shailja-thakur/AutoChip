module top_module (
    input  [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Generate the out_both signal
    assign out_both = in[99:1] & in[98:0];

    // Generate the out_any signal
    assign out_any = in[99:1];

    // Generate the out_different signal
    assign out_different[99] = in[99] ^ in[98];
    assign out_different[98:0] = in[98:0] ^ in[99:1];

endmodule
