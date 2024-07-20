module top_module(
    input x,
    input y,
    output z
);

    wire xor_out;
    
    // Implement the XOR operation between x and y
    assign xor_out = x ^ y;
    
    // Implement the AND operation between xor_out and x
    assign z = xor_out & x;

endmodule
