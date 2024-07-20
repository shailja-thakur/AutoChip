module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire xor_result;

    // Perform bitwise XOR operation on the inputs
    assign xor_result = a ^ b ^ c ^ d;

    // Invert the XOR result to get the desired logic function
    assign q = ~xor_result;

endmodule
