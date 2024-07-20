module module_A(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module module_B(
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

wire z1, z2, z3, z4;

module_A inst_A1(
    .x(x),
    .y(y),
    .z(z1)
);

module_B inst_B1(
    .x(x),
    .y(y),
    .z(z2)
);

module_A inst_A2(
    .x(x),
    .y(y),
    .z(z3)
);

module_B inst_B2(
    .x(x),
    .y(y),
    .z(z4)
);

wire or_out, and_out;
assign or_out = z1 | z2;
assign and_out = z3 & z4;

assign z = or_out ^ and_out;

endmodule
