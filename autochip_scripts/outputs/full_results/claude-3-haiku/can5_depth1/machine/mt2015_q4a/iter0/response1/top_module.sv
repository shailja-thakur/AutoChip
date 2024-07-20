module top_module(
    input x,
    input y,
    output z
);

    wire xor_out;
    
    // Implement the XOR operation
    assign xor_out = x ^ y;
    
    // Implement the AND operation
    assign z = xor_out & x;

endmodule
