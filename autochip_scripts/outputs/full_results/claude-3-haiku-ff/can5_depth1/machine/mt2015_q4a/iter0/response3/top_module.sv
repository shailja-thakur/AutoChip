module top_module(
    input x,
    input y,
    output z
);

    wire xor_result;
    
    // Compute the XOR of the two inputs
    assign xor_result = x ^ y;
    
    // Compute the output z as the logical AND of x and the XOR result
    assign z = x & xor_result;

endmodule
