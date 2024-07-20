module top_module(
    input x,
    input y,
    output z
);

    wire xor_out;
    
    // Implement the XOR of the two inputs
    assign xor_out = x ^ y;
    
    // Implement the AND of the XOR output and the first input x
    assign z = xor_out & x;

endmodule
