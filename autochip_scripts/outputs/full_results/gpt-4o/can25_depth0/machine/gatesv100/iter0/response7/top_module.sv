module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    
    // Shift in by 1 bit to the left
    assign in_shifted = {in[98:0], in[99]};
    
    // Generate out_both, out_any, and out_different
    assign out_both = in[99:1] & in[98:0];  // Perform bit-wise AND, resulting in a 99-bit wide vector
    assign out_any = in | in_shifted;       // Perform bit-wise OR, resulting in a 100-bit wide vector
    assign out_different = in ^ in_shifted; // Perform bit-wise XOR, resulting in a 100-bit wide vector

endmodule
