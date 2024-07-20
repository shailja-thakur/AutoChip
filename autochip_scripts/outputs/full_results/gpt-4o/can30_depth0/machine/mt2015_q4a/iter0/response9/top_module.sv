module top_module(
    input x,
    input y,
    output z);

    // Intermediate signal for XOR operation
    wire xor_xy;

    // XOR the inputs x and y
    assign xor_xy = x ^ y;

    // AND the result of XOR with input x
    assign z = xor_xy & x;

endmodule
