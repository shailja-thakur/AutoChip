module A(
    input x,
    input y,
    output z
);
assign z = (x ^ y) & x;
endmodule
module B(
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
wire z1, z2, z3;

A a1(
    .x(x),
    .y(y),
    .z(z1)
);

B b1(
    .x(x),
    .y(y),
    .z(z2)
);

A a2(
    .x(x),
    .y(y),
    .z(z3)
);

B b2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z2) ^ (z3 & z4);
endmodule
