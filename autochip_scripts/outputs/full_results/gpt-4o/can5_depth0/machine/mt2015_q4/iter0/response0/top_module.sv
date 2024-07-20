module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;  // Intermediate signals

    // First gate
    and and_gate1 (
        .a(x),
        .b(y),
        .z(out1)
    );

    // Second gate
    or or_gate2 (
        .a(y),
        .b(x),
        .z(out2)
    );

    // Third gate
    xor xor_gate3 (
        .a(out1),
        .b(out2),
        .z(z)
    );

endmodule
