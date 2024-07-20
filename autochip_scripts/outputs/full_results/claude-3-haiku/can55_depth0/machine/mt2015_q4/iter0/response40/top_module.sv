module top_module(
    input x,
    input y,
    output z
);

    wire a, b;

    and_gate u1 (
        .a(y),
        .b(x),
        .out(a)
    );

    and_gate u2 (
        .a(x),
        .b(y),
        .out(b)
    );

    and_gate u3 (
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
