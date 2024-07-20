module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire to hold the XOR result
    wire xor_result;

    // Perform XOR operation on the inputs x and y
    assign xor_result = x ^ y;

    // Perform AND operation between the XOR result and the input x
    assign z = xor_result & x;

endmodule
