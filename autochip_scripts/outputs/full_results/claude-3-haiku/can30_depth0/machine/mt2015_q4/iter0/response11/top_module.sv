module top_module(
    input x,
    input y,
    output z
);

wire a, b, c;

and_gate gate1 (
    .a(x),
    .b(y),
    .out(a)
);

and_gate gate2 (
    .a(y),
    .b(x),
    .out(b)
);

and_gate gate3 (
    .a(a),
    .b(b),
    .out(z)
);

endmodule
module and_gate(
    input a,
    input b,
    output out
);

assign out = a & b;

endmodule
