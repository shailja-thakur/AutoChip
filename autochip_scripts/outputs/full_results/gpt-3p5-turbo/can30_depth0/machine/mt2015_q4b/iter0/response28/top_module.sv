module top_module(
    input x,
    input y,
    output z);

    // XOR gate
    assign xor_output = x ^ y;

    // z is the negation of xor_output
    assign z = !xor_output;

endmodule
