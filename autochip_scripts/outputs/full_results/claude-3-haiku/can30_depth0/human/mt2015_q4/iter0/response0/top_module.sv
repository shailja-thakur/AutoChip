module ModuleA(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module ModuleB(
    input x,
    input y,
    output z
);

assign z = (x == 0 && y == 0) || (x == 1 && y == 1);

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3, z4;

ModuleA A1(
    .x(x),
    .y(y),
    .z(z1)
);

ModuleB B1(
    .x(x),
    .y(y),
    .z(z2)
);

ModuleA A2(
    .x(x),
    .y(y),
    .z(z3)
);

ModuleB B2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z2) ^ (z3 & z4);

endmodule
