module top_module(
    input x,
    input y,
    output z
);

    wire a, b;

    // First gate
    and gate1(a, x, y);

    // Second gate
    and gate2(b, y, x);

    // Third gate
    and gate3(z, a, b);

endmodule
