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

assign z = ~((x & ~y) | (~x & y));

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3;

ModuleA A1 (
    .x(x),
    .y(y),
    .z(z1)
);

ModuleA A2 (
    .x(x),
    .y(y),
    .z(z2)
);

ModuleB B1 (
    .x(x),
    .y(y),
    .z(z3)
);

ModuleB B2 (
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z3) ^ (z2 & z4);

endmodule
