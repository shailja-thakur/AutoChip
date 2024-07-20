module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shifted input signal by one bit
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0};

    // Generate out_both signal: bitwise AND of in and in_shifted
    assign out_both = in[98:0] & in_shifted[98:0];

    // Generate out_any signal: bitwise OR of in and in_shifted
    assign out_any = in | in_shifted;

    // Generate out_different signal: bitwise XOR of in and in_shifted
    // First bit of out_different is the XOR of first bit of in and last bit of in_shifted
    assign out_different = in ^ {in[0], in[99:1]};

endmodule
