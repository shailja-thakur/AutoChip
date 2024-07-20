module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;

    // Shift the input signal by one bit to the right
    assign in_shifted[99:1] = in[98:0];
    assign in_shifted[0] = 1'b0;

    // Generate out_both signal
    assign out_both = in[99:1] & in_shifted[99:1];

    // Generate out_any signal
    assign out_any[99:1] = in[99:1] | in_shifted[99:1];
    assign out_any[0] = in[0];

    // Generate out_different signal
    assign out_different[99] = in[99] ^ in_shifted[99];
    assign out_different[98:0] = in[98:0] ^ in_shifted[98:0];

endmodule
