module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, c;

    and(a1, x, y);
    and(b1, y, x);
    and(a2, x, y);
    and(b2, y, x);
    and(c, a1, b2);

    assign z = c;

endmodule
