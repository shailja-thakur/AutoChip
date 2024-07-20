module top_module(
    input x,
    input y,
    output z
);

    wire a, b;

    and(a, x, y);
    and(b, y, x);
    or(z, a, b);

endmodule
