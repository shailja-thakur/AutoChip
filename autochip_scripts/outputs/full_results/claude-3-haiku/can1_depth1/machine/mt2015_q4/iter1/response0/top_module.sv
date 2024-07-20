module top_module(
    input x,
    input y,
    output z
);

    wire a, b;

    // First gate
    or(a, x, y);

    // Second gate
    or(b, y, x);

    // Third gate
    and(z, a, b);

endmodule
