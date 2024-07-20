module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    and_gate and1(
        .a(x),
        .b(y),
        .z(a)
    );

    and_gate and2(
        .a(x),
        .b(y),
        .z(b)
    );

    or_gate or1(
        .a(a),
        .b(b),
        .z(z)
    );

endmodule
module and_gate(
    input a,
    input b,
    output z
);

    assign z = a & b;

endmodule
module or_gate(
    input a,
    input b,
    output z
);

    assign z = a | b;

endmodule
