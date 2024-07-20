module top_module (
    input x,
    input y,
    output z
);

wire a;
wire b;

and gate1 (
    .a(x),
    .b(y),
    .z(a)
);

and gate2 (
    .a(y),
    .b(x),
    .z(b)
);

or gate3 (
    .a(a),
    .b(b),
    .z(z)
);

endmodule
