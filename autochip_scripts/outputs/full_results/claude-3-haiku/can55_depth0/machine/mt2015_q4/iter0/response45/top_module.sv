module top_module(
    input x,
    input y,
    output z
);

    wire a, b;

    gate_1 u1 (
        .a(x),
        .b(y),
        .out(a)
    );

    gate_2 u2 (
        .a(y),
        .b(x),
        .out(b)
    );

    gate_3 u3 (
        .a(a),
        .b(b),
        .out(z)
    );

endmodule
module gate_1(
    input a,
    input b,
    output out
);
    assign out = a & b;
endmodule
module gate_2(
    input a,
    input b,
    output out
);
    assign out = a | b;
endmodule
module gate_3(
    input a,
    input b,
    output out
);
    assign out = a ^ b;
endmodule
