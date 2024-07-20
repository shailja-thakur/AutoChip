module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shifted version of the input signal
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0};

    // Generate the out_both signal
    assign out_both = in[98:0] & in_shifted[99:1];

    // Generate the out_any signal
    assign out_any[99:1] = in | in_shifted;

    // Generate the out_different signal
    assign out_different[99] = in[99] ^ in_shifted[0];
    assign out_different[98:0] = in[98:0] ^ in_shifted[99:1];

endmodule
