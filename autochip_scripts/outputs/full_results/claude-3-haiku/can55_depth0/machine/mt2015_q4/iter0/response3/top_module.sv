module top_module(
    input x,
    input y,
    output z
);

wire a1, a2, b1, b2;

// First logic gate
and(a1, x, y);
and(b1, y, x);

// Second logic gate
and(a2, y, x);
and(b2, x, y);

// Third logic gate
and(z, a1, b2);

endmodule
