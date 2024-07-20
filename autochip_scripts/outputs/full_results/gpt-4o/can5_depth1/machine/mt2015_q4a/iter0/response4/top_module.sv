module top_module(
    input x,
    input y,
    output z);

    // Internal wire to hold the result of XOR operation between x and y
    wire xor_result;
    
    // Perform XOR operation between x and y
    assign xor_result = x ^ y;
    
    // Perform AND operation between xor_result and the first input x
    assign z = xor_result & x;

endmodule
