module top_module(
    input x,
    input y,
    output z);

    wire a, b;

    // First gate
    and gate1(
        .a(x),
        .b(y),
        .z(a)
    );

    // Second gate
    or gate2(
        .a(y),
        .b(x),
        .z(b)
    );

    // Third gate
    nand gate3(
        .a(a),
        .b(b),
        .z(z)
    );

endmodule
module and(
    input a,
    input b,
    output z);

    assign z = a & b;

endmodule
module or(
    input a,
    input b,
    output z);

    assign z = a | b;

endmodule
module nand(
    input a,
    input b,
    output z);

    assign z = ~(a & b);

endmodule
