module top_module(
    input x,
    input y,
    output z
);

wire a, b, c;

gate1 u1 (
    .a(x),
    .b(y),
    .out(a)
);

gate2 u2 (
    .a(y),
    .b(x),
    .out(b)
);

gate3 u3 (
    .a(a),
    .b(b),
    .out(z)
);

endmodule
module gate1(
    input a,
    input b,
    output out
);
    assign out = a & b;
endmodule
module gate2(
    input a,
    input b,
    output out
);
    assign out = a | b;
endmodule
module gate3(
    input a,
    input b,
    output out
);
    assign out = a ^ b;
endmodule
