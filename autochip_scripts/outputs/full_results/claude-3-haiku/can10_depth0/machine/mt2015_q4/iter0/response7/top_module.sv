module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, c3;

    // First gate
    and(a1, x, y);
    and(b1, y, x);

    // Second gate
    and(a2, y, x);
    and(b2, x, y);

    // Third gate
    and(c3, a1, b2);
    or(z, c3);

endmodule
