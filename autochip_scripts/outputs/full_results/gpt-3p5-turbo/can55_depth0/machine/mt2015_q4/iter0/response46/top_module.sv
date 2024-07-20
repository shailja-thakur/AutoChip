module top_module(
    input x,
    input y,
    output z);

    wire gate1_output;
    wire gate2_output;

    not gate1 (
        .a(x),
        .z(gate1_output)
    );

    not gate2 (
        .a(y),
        .z(gate2_output)
    );

    and gate3 (
        .a(gate1_output),
        .b(gate2_output),
        .z(z)
    );

endmodule
