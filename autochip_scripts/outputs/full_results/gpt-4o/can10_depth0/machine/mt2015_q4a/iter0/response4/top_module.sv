module top_module(
    input x,
    input y,
    output z);
    
    // Intermediate wire to hold the result of XOR operation
    wire xor_xy;
    
    // XOR operation between the two inputs
    assign xor_xy = x ^ y;
    
    // AND operation between the XOR result and the first input x
    assign z = xor_xy & x;

endmodule
