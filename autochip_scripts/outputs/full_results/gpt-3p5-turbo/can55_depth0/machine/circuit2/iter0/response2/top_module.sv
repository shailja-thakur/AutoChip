module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    wire xor_output;
    
    assign xor_output = a ^ b ^ c ^ d;
    assign q = ~xor_output;
    
endmodule
