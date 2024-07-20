module ModuleA(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

module ModuleB(
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

ModuleA inst_A1(
    .x(x),
    .y(y),
    .z(z1)
);

ModuleB inst_B1(
    .x(x),
    .y(y),
    .z(z2)
);

ModuleA inst_A2(
    .x(x),
    .y(y),
    .z(z3)
);

ModuleB inst_B2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z2) ^ (z3 & z4);

endmodule
