module top_module(
    input x,
    input y,
    output z
);

    wire a1, a2, b1, b2;

    // First logic gate
    and(a1, x, y);

    // Second logic gate
    and(b1, y, x);

    // Third logic gate
    and(a2, a1, b1);
    assign z = a2;

endmodule
