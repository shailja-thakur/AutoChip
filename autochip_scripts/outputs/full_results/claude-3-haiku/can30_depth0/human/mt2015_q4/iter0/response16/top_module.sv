module module_a(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module module_b(
    input x,
    input y,
    output z
);

assign z = ((x == 0) && (y == 0)) || ((x == 1) && (y == 0)) || ((x == 1) && (y == 1));

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire a1_out, a2_out, b1_out, b2_out;

module_a a1(
    .x(x),
    .y(y),
    .z(a1_out)
);

module_a a2(
    .x(x),
    .y(y),
    .z(a2_out)
);

module_b b1(
    .x(x),
    .y(y),
    .z(b1_out)
);

module_b b2(
    .x(x),
    .y(y),
    .z(b2_out)
);

wire or_out, and_out;

or(or_out, a1_out, b1_out);
and(and_out, a2_out, b2_out);

xor(z, or_out, and_out);

endmodule
