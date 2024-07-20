module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Define the second input signal as the shifted version of the first input
    wire [99:0] shifted_in;
    assign shifted_in = in << 1;

    // Generate out_both signal
    assign out_both = in[99:1] & shifted_in[98:0];

    // Generate out_any signal
    assign out_any = in | shifted_in;

    // Generate out_different signal
    assign out_different[99:1] = in[99:1] ^ shifted_in[98:0];
    assign out_different[0] = in[0] ^ shifted_in[99];

endmodule
