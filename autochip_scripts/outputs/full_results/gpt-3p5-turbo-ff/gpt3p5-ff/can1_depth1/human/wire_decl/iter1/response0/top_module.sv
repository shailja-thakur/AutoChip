module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire intermediate_wire1;
    wire intermediate_wire2;

    and gate1 (
        .a(a),
        .b(b),
        .z(intermediate_wire1)
    );

    and gate2 (
        .a(c),
        .b(d),
        .z(intermediate_wire2)
    );

    or gate3 (
        .a(intermediate_wire1),
        .b(intermediate_wire2),
        .z(out)
    );

    not gate4 (
        .a(out),
        .z(out_n)
    );

endmodule
module and (
    input a,
    input b,
    output z );

    assign z = a & b;

endmodule
module or (
    input a,
    input b,
    output z );

    assign z = a | b;

endmodule
module not (
    input a,
    output z );

    assign z = ~a;

endmodule
