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

assign z = ((x == 0) && (y == 0)) || ((x == 1) && (y == 0)) || ((x == 0) && (y == 1));

module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3, z4;

A module_a1(
    .x(x),
    .y(y),
    .z(z1)
);

A module_a2(
    .x(x),
    .y(y),
    .z(z2)
);

B module_b1(
    .x(x),
    .y(y),
    .z(z3)
);

B module_b2(
    .x(x),
    .y(y),
    .z(z4)
);

or or_gate(
    .a(z1),
    .b(z3),
    .z(z5)
);

and and_gate(
    .a(z2),
    .b(z4),
    .z(z6)
);

xor xor_gate(
    .a(z5),
    .b(z6),
    .z(z)
);

endmodule
