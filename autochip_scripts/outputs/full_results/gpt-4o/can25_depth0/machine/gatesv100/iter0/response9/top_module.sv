module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by one bit to the right
    wire [99:0] in_shifted;
    assign in_shifted = in >> 1;

    // Generate the out_both signal by performing a bit-wise AND operation 
    // between the first 99 bits of the input and the last 99 bits of the shifted input
    assign out_both = in[98:0] & in_shifted[98:0];
    
    // Generate the out_any signal by performing a bit-wise OR operation 
    // between the input and the shifted input
    assign out_any = in | in_shifted;
    
    // Generate the out_different signal by performing a bit-wise XOR operation 
    // between the input and the shifted input. Special case for the first bit
    assign out_different[0] = in[0] ^ in_shifted[99];
    assign out_different[99:1] = in[99:1] ^ in_shifted[99:1];

endmodule
