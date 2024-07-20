module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire xor_output;
    
    // Implements the XOR operation on the inputs
    assign xor_output = a ^ b ^ c ^ d;
    
    // Inverts the result of XOR operation
    assign q = ~xor_output;
    
endmodule
