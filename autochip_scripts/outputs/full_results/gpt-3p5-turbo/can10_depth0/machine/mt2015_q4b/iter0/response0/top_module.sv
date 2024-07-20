module top_module(
    input x,
    input y,
    output z);

    // Declare intermediate wires
    wire x_xor_y;
    wire x_or_y;

    // Compute x XOR y
    assign x_xor_y = x ^ y;

    // Compute x OR y
    assign x_or_y = x | y;

    // Compute logical negation of x XOR y
    assign z = ~x_xor_y;

endmodule
