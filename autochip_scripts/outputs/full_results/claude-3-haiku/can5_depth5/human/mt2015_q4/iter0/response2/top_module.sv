module moduleA(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module moduleB(
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

wire z1, z2, z3;

moduleA a1(
    .x(x),
    .y(y),
    .z(z1)
);

moduleB b1(
    .x(x),
    .y(y),
    .z(z2)
);

moduleA a2(
    .x(x),
    .y(y),
    .z(z3)
);

moduleB b2(
    .x(x),
    .y(y),
    .z(z)
);

assign z = (z1 | z2) ^ (z3 & z);

endmodule
