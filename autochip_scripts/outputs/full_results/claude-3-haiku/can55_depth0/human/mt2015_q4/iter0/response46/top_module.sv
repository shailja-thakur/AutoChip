module Module_A(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module Module_B(
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

wire z_a1, z_b1, z_a2, z_b2;

Module_A A1(
    .x(x),
    .y(y),
    .z(z_a1)
);

Module_B B1(
    .x(x),
    .y(y),
    .z(z_b1)
);

Module_A A2(
    .x(x),
    .y(y),
    .z(z_a2)
);

Module_B B2(
    .x(x),
    .y(y),
    .z(z_b2)
);

assign z = (z_a1 | z_b1) ^ (z_a2 & z_b2);

endmodule
