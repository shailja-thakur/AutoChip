module top_module(
    input x,
    input y,
    output z
);

    wire xor_out;
    
    // Compute the XOR of the two inputs
    assign xor_out = x ^ y;
    
    // Compute the final output z
    assign z = xor_out & x;

endmodule
