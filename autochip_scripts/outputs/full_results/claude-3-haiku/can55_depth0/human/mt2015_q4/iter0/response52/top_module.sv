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
assign z = ((x == 0) & (y == 0)) | ((x == 1) & (y == 0)) | ((x == 0) & (y == 1));
endmodule
module top_module(
    input x,
    input y,
    output z
);
wire a1, b1, a2, b2, or_out, and_out;

module_A submodule_A1(
    .x(x),
    .y(y),
    .z(a1)
);

module_A submodule_A2(
    .x(x),
    .y(y),
    .z(a2)
);

module_B submodule_B1(
    .x(x),
    .y(y),
    .z(b1)
);

module_B submodule_B2(
    .x(x),
    .y(y),
    .z(b2)
);

or or_gate(
    .a(a1),
    .b(b1),
    .y(or_out)
);

and and_gate(
    .a(a2),
    .b(b2),
    .y(and_out)
);

xor xor_gate(
    .a(or_out),
    .b(and_out),
    .y(z)
);
endmodule
