module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

// Perform bitwise XOR operation on the inputs
wire xor_result = a ^ b ^ c ^ d;

// Invert the XOR result to get the desired logic function
assign q = ~xor_result;

endmodule
