module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire for xor result
    wire xor_result;

    // Perform XOR operation between x and y
    assign xor_result = x ^ y;

    // Perform AND operation between xor_result and x to get the final output z
    assign z = xor_result & x;

endmodule
