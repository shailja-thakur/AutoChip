module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // XOR operation on the inputs
    wire xor_result = a ^ b ^ c ^ d;

    // Invert the result
    assign q = ~xor_result;

endmodule
