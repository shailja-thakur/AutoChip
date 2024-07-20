module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Perform bitwise XOR on all inputs
    wire xor_result;
    assign xor_result = a ^ b ^ c ^ d;

    // Invert the result of XOR operation to get the desired output
    assign q = ~xor_result;

endmodule
