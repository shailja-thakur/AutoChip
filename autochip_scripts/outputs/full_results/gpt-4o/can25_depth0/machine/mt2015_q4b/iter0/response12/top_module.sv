module top_module(
    input x,
    input y,
    output z);

    // The output is the logical negation of the XOR of the inputs
    assign z = ~(x ^ y);

endmodule
