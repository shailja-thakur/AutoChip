module A(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

module B(
    input x,
    input y,
    output z
);

assign z = (x == 0 && y == 0) || (x == 1 && y == 1);

module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_a2, z_b1, z_b2;

A a1(.x(x), .y(y), .z(z_a1));
A a2(.x(x), .y(y), .z(z_a2));
B b1(.x(x), .y(y), .z(z_b1));
B b2(.x(x), .y(y), .z(z_b2));

assign z = (z_a1 | z_b1) ^ (z_a2 & z_b2);

endmodule
