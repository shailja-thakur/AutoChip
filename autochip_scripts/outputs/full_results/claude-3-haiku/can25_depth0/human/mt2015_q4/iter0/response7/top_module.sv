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

assign z = (~x & ~y) | (x & ~y) | (~x & y) | (x & y);

module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3, z4;

A sub_a1(
    .x(x),
    .y(y),
    .z(z1)
);

A sub_a2(
    .x(x),
    .y(y),
    .z(z2)
);

B sub_b1(
    .x(x),
    .y(y),
    .z(z3)
);

B sub_b2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z3) ^ (z2 & z4);

endmodule
