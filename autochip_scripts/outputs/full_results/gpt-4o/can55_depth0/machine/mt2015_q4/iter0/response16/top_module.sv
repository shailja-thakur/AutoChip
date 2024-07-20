module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND gate)
    and g1 (
        .a(x),
        .b(y),
        .y(out1)
    );

    // Second gate (OR gate)
    or g2 (
        .a(y),
        .b(x),
        .y(out2)
    );

    // Third gate (XOR gate)
    xor g3 (
        .a(out1),
        .b(out2),
        .y(z)
    );

endmodule
