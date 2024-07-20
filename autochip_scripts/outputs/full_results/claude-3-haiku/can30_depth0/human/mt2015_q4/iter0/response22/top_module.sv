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

assign z = (x & ~y) | (~x & y);

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire A1_out, A2_out, B1_out, B2_out;

module_A A1 (
    .x(x),
    .y(y),
    .z(A1_out)
);

module_A A2 (
    .x(x),
    .y(y),
    .z(A2_out)
);

module_B B1 (
    .x(x),
    .y(y),
    .z(B1_out)
);

module_B B2 (
    .x(x),
    .y(y),
    .z(B2_out)
);

assign z = (A1_out | B1_out) ^ (A2_out & B2_out);

endmodule
