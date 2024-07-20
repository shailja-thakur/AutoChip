module top_module(
    input x,
    input y,
    output z
);

    wire xor_result;
    
    // Implement the XOR operation on the two inputs
    assign xor_result = x ^ y;
    
    // Implement the AND operation between the XOR result and the first input x
    assign z = xor_result & x;

endmodule
