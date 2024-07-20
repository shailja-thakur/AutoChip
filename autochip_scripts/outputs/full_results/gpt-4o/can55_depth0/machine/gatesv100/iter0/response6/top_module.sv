module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shifting the input signal to create the second input
    wire [99:0] shifted_in = {in[98:0], 1'b0};

    // Generating the out_both signal
    assign out_both = in[99:1] & shifted_in[99:1];

    // Generating the out_any signal
    assign out_any = in | shifted_in;

    // Generating the out_different signal
    assign out_different = in ^ shifted_in;

endmodule
