module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // Intermediate wire to store the result of the XOR operation
    wire xor_result;

    // Perform the XOR operation on inputs a, b, c, and d
    assign xor_result = a ^ b ^ c ^ d;
    
    // Invert the result using a logical NOT gate
    assign q = ~xor_result;

endmodule
