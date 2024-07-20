module A(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

module B(
    input x,
    input y,
    output z
);

assign z = (x == 0 && y == 0) || (x == 1 && y == 1);

module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3;

A a1(
    .x(x),
    .y(y),
    .z(z1)
);

A a2(
    .x(x),
    .y(y),
    .z(z2)
);

B b1(
    .x(x),
    .y(y),
    .z(z3)
);

B b2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z3) ^ (z2 & z4);

endmodule
