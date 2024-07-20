module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Generate out_both signal
    assign out_both = in & {in[98:0], 1'b0};

    // Generate out_any signal
    assign out_any = in | {in[98:0], 1'b0};

    // Generate out_different signal
    assign out_different[99] = in[99] ^ in[0];
    assign out_different[98:0] = in[98:0] ^ {in[99:1]};

endmodule
