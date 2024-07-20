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
assign z = (x == 0 && y == 0) || (x == 1 && y == 0) || (x == 0 && y == 1);
endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_a2, z_b1, z_b2;

ModuleA a1(
    .x(x),
    .y(y),
    .z(z_a1)
);

ModuleA a2(
    .x(x),
    .y(y),
    .z(z_a2)
);

ModuleB b1(
    .x(x),
    .y(y),
    .z(z_b1)
);

ModuleB b2(
    .x(x),
    .y(y),
    .z(z_b2)
);

wire or_out, and_out;
assign or_out = z_a1 | z_b1;
assign and_out = z_a2 & z_b2;

assign z = or_out ^ and_out;

endmodule
