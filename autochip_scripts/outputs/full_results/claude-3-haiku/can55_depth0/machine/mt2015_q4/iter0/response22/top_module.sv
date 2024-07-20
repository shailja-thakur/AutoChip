module top_module(
    input x,
    input y,
    output z
);

    wire a, b;

    and_gate first_gate(
        .a(x),
        .b(y),
        .out(a)
    );

    and_gate second_gate(
        .a(y),
        .b(x),
        .out(b)
    );

    and_gate third_gate(
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
