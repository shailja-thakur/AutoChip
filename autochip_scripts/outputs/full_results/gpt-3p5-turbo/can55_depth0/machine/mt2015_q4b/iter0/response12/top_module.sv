module top_module(
    input x,
    input y,
    output z);
    
    // Declare internal wire for XOR operation
    wire xor_output;
    
    // XOR operation to calculate the negation of x and y
    assign xor_output = x ^ y;
    
    // Invert the output of the XOR operation
    assign z = ~xor_output;
    
endmodule
