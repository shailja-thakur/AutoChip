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

assign z = ~((x ^ y) & x);

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z1, z2;

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
    .z(z1)
);

ModuleB B2(
    .x(x),
    .y(y),
    .z(z2)
);

assign z = (z1 | z2) ^ (z1 & z2);

endmodule
