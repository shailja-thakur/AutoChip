module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;  // Shifted version of input signal

    assign in_shifted = {in[98:0], 1'b0};  // Shift input by one bit

    // Generate out_both signal
    assign out_both = in[99:1] & in_shifted[99:1];

    // Generate out_any signal
    assign out_any = in | in_shifted;

    // Generate out_different signal
    assign out_different[99:1] = in[99:1] ^ in_shifted[99:1];
    assign out_different[0] = in[0] ^ in_shifted[99];

endmodule
