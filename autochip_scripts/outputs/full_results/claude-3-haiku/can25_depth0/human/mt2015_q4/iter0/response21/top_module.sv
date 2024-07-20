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

assign z = ((x == 0) && (y == 0)) || ((x == 1) && (y == 1)) || ((x == 0) && (y == 1));

module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3, z4;

module_A submodule_A1(
    .x(x),
    .y(y),
    .z(z1)
);

module_A submodule_A2(
    .x(x),
    .y(y),
    .z(z2)
);

module_B submodule_B1(
    .x(x),
    .y(y),
    .z(z3)
);

module_B submodule_B2(
    .x(x),
    .y(y),
    .z(z4)
);

or(z1_or, z1, z3);
and(z2_and, z2, z4);
xor(z, z1_or, z2_and);

endmodule
