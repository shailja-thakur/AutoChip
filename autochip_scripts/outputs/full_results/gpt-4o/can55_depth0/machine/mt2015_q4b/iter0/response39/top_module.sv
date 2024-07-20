module top_module(
    input x,
    input y,
    output z);

    // XOR the inputs and then negate the result
    assign z = ~(x ^ y);

endmodule
