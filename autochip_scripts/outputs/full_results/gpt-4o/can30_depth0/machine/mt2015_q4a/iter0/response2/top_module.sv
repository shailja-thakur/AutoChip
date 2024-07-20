module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire to hold the XOR result
    wire xor_result;
    
    // XOR operation between inputs x and y
    assign xor_result = x ^ y;
    
    // AND operation between XOR result and input x
    assign z = xor_result & x;

endmodule
