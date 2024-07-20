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

assign z = (x & ~y) | (~x & y) | (x & y);

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_b1, z_a2, z_b2;

moduleA a1(
    .x(x),
    .y(y),
    .z(z_a1)
);

moduleB b1(
    .x(x),
    .y(y),
    .z(z_b1)
);

moduleA a2(
    .x(x),
    .y(y),
    .z(z_a2)
);

moduleB b2(
    .x(x),
    .y(y),
    .z(z_b2)
);

assign z = (z_a1 | z_b1) ^ (z_a2 & z_b2);

endmodule
