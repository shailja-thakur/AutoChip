module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // First gate
    and(a1, x, y);
    and(b1, x, y);

    // Second gate
    and(a2, y, x);
    and(b2, y, x);

    // Third gate
    and(out1, a1, b2);
    and(out2, b1, a2);
    or(z, out1, out2);

endmodule
