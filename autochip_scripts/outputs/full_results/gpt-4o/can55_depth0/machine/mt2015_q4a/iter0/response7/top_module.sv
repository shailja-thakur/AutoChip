module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire for XOR operation
    wire xor_result;

    // XOR the inputs x and y
    assign xor_result = x ^ y;

    // AND the XOR result with the input x
    assign z = xor_result & x;

endmodule
