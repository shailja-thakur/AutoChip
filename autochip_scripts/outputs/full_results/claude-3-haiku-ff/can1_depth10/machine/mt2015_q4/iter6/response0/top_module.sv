module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    // First gate
    and(a, x, y);

    // Second gate
    and(b, x, y);

    // Third gate
    or(z, a, b);

endmodule
