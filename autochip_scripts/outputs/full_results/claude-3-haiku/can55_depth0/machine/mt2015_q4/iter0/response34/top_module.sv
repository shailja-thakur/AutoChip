module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, a3, b3;

    gate1 g1 (
        .a(x),
        .b(y),
        .out(a1)
    );

    gate2 g2 (
        .a(y),
        .b(x),
        .out(b2)
    );

    gate3 g3 (
        .a(a1),
        .b(b2),
        .out(z)
    );

endmodule
module gate1 (
    input a,
    input b,
    output out
);
    // Logic for gate1
    assign out = a & b;
endmodule
module gate2 (
    input a,
    input b,
    output out
);
    // Logic for gate2
    assign out = a | b;
endmodule
module gate3 (
    input a,
    input b,
    output out
);
    // Logic for gate3
    assign out = a ^ b;
endmodule
