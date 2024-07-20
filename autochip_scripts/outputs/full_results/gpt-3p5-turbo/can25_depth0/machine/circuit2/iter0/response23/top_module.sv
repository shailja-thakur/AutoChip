module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire xor_output;
    
    // Perform XOR operation on the inputs
    assign xor_output = a ^ b ^ c ^ d;
    
    // Invert the XOR output
    assign q = ~xor_output;

endmodule
