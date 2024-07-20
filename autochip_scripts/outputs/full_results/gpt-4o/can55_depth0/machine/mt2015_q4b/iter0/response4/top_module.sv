module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire to hold the XOR result
    wire xor_result;
    
    // XOR gate
    assign xor_result = x ^ y;
    
    // Logical negation of XOR result to get the final output
    assign z = ~xor_result;

endmodule
