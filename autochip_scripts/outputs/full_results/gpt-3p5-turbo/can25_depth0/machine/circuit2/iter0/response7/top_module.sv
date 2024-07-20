module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // perform bitwise XOR operation on inputs
    wire xor_result;
    assign xor_result = a ^ b ^ c ^ d;
    
    // invert the result
    assign q = ~xor_result;

endmodule
