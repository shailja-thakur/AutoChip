module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Second input signal is the first input signal shifted by one bit to the right
    wire [99:0] in_shifted = in >> 1;
    
    // Generating out_both signal
    assign out_both = in[98:0] & in_shifted[98:0];

    // Generating out_any signal
    assign out_any = in | in_shifted;

    // Generating out_different signal
    assign out_different[99] = in[99] ^ in_shifted[0];  // First bit of out_different
    assign out_different[98:0] = in[98:0] ^ in_shifted[98:0];

endmodule
