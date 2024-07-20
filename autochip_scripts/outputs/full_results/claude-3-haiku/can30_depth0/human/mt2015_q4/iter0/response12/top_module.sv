module module_a(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

module module_b(
    input x,
    input y,
    output z
);

assign z = ((x == 0) & (y == 0)) | ((x == 1) & (y == 0)) | ((x == 0) & (y == 1));

module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_a2, z_b1, z_b2;

module_a u_a1 (
    .x(x),
    .y(y),
    .z(z_a1)
);

module_a u_a2 (
    .x(x),
    .y(y),
    .z(z_a2)
);

module_b u_b1 (
    .x(x),
    .y(y),
    .z(z_b1)
);

module_b u_b2 (
    .x(x),
    .y(y),
    .z(z_b2)
);

assign z = (z_a1 | z_b1) ^ (z_a2 & z_b2);

endmodule
