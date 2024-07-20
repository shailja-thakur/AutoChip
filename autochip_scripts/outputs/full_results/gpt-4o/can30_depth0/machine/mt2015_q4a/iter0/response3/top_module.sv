module top_module(
    input x,
    input y,
    output z);

    // Perform XOR operation between x and y
    wire xor_result;
    assign xor_result = x ^ y;
    
    // Perform AND operation between xor_result and x
    assign z = xor_result & x;

endmodule
