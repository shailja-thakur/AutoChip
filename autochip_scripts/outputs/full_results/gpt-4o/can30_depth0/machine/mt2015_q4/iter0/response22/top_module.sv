module top_module(
    input x,
    input y,
    output z
);
    wire out1, out2;

    // First gate (AND gate)
    and u1 (
        .a(x),
        .b(y),
        .y(out1)
    );

    // Second gate (OR gate)
    or u2 (
        .a(y),
        .b(x),
        .y(out2)
    );

    // Third gate (XOR gate)
    xor u3 (
        .a(out1),
        .b(out2),
        .y(z)
    );

endmodule
