module top_module(
    input x,
    input y,
    output z
);

    wire xor_out;
    
    // Implement the XOR logic
    assign xor_out = x ^ y;
    
    // Implement the AND logic
    assign z = xor_out & x;

endmodule
