module top_module(
    input x,
    input y,
    output z
);

    wire a, b;

    // First logic gate
    and(a, x, y);

    // Second logic gate 
    and(b, y, x);

    // Third logic gate
    and(z, a, b);

endmodule
