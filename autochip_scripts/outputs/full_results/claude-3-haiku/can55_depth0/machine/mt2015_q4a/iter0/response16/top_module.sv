module top_module(
    input x,
    input y,
    output z
);

    wire xor_result;
    
    // Compute the XOR of the two inputs
    assign xor_result = x ^ y;
    
    // Compute the final output z
    assign z = xor_result & x;

endmodule
