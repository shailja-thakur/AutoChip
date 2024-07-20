module top_module(
    input x,
    input y,
    output z);

    // Intermediate signal for XOR operation
    wire xor_result;

    // Perform XOR operation between x and y
    assign xor_result = x ^ y;

    // Perform AND operation between xor_result and x to produce z
    assign z = xor_result & x;

endmodule
