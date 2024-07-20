module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // Perform the XOR operation on the inputs
    wire xor_out = a ^ b ^ c ^ d;

    // Invert the result to get the desired logic function
    assign q = ~xor_out;

endmodule
