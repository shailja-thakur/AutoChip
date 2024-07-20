module top_module(
    input x,
    input y,
    output z
);

wire a1, b1, a2, b2, c1, c2;

// Gate 1
and(a1, x, y);
and(b1, y, x);

// Gate 2
and(a2, y, x);
and(b2, x, y);

// Gate 3
and(c1, a1, b2);
and(c2, b1, a2);
or(z, c1, c2);

endmodule
