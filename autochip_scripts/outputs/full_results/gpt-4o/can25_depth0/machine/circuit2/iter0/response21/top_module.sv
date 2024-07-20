module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // Perform bitwise XOR on the inputs
    wire xor_result = a ^ b ^ c ^ d;

    // Invert the result of the XOR operation
    assign q = ~xor_result;

endmodule
