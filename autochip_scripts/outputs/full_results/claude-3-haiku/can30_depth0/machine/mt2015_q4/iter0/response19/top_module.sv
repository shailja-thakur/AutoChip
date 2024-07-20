module top_module(
    input x,
    input y,
    output z
);

wire a1, b1, a2, b2, a3, b3;

and gate1(
    .a(x),
    .b(y),
    .out(a1)
);

and gate2(
    .a(y),
    .b(x),
    .out(b2)
);

and gate3(
    .a(a1),
    .b(b2),
    .out(z)
);

endmodule
