module module_A(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

module module_B(
    input x,
    input y,
    output z
);

assign z = (~x & ~y) | (x & ~y) | (x & y);

module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3, z4;

module_A A1(
    .x(x),
    .y(y),
    .z(z1)
);

module_B B1(
    .x(x),
    .y(y),
    .z(z2)
);

module_A A2(
    .x(x),
    .y(y),
    .z(z3)
);

module_B B2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z2) ^ (z3 & z4);

endmodule
