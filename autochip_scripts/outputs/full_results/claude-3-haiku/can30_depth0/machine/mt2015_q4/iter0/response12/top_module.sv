module top_module(
    input x,
    input y,
    output z
);

wire a1, b1, a2, b2, a3, b3;

and(a1, x, y);
and(b1, y, x);
and(a3, a1, b2);
and(b3, b1, a2);
and(z, a3, b3);

endmodule
