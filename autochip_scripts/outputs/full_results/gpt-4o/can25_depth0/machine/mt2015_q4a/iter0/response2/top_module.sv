module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire for the XOR operation
    wire xor_result;

    // Perform XOR operation on inputs x and y
    assign xor_result = x ^ y;

    // Perform AND operation between x and the XOR result
    assign z = x & xor_result;

endmodule
