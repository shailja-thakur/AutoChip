module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // First gate
    and(a1, x, y);
    and(b1, x, ~y);

    // Second gate
    and(a2, ~x, y);
    and(b2, x, y);

    // Third gate
    or(out1, a1, b1);
    or(out2, a2, b2);
    or(z, out1, out2);

endmodule
