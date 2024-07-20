module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    and gate1(a, x, y);
    and gate2(b, y, x);
    or gate3(z, a, b);

endmodule
