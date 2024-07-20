module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire [3:0] xor_result;
    
    // XOR operation between the inputs
    assign xor_result = {a, b, c, d} ^ 4'b1;
    
    // Invert the XOR result
    assign q = ~xor_result[3];
    
endmodule
