module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, c;

    gate_1 gate1 (
        .a(x),
        .b(y),
        .out(a1)
    );

    gate_2 gate2 (
        .a(y),
        .b(x),
        .out(b2)
    );

    gate_3 gate3 (
        .a(a1),
        .b(b2),
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
