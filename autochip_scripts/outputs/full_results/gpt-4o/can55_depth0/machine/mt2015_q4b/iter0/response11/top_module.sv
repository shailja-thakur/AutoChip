module top_module(
    input x,
    input y,
    output z);

    // Internal wire to hold the result of the XOR operation
    wire xor_result;

    // XOR operation between inputs x and y
    assign xor_result = x ^ y;
    
    // Negation of the XOR result
    assign z = ~xor_result;

endmodule
