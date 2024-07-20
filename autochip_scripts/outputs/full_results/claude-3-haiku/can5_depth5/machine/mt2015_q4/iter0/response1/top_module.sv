module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // First logic gate
    and(out1, x, y);

    // Second logic gate
    and(out2, y, x);

    // Third logic gate
    and(z, out1, out2);

endmodule
