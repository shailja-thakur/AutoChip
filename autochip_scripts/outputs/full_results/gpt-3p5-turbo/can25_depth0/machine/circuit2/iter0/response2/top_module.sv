module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // XOR operation
    wire xor_ab = a ^ b;
    wire xor_cd = c ^ d;

    // Bitwise XOR of xor_ab and xor_cd
    wire xor_output = xor_ab ^ xor_cd;

    // Invert the output
    assign q = ~xor_output;

endmodule
