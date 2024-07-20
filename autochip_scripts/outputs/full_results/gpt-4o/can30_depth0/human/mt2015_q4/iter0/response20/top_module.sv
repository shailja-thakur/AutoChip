module A(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B(
    input x,
    input y,
    output z
);
    assign z = (x == 0 && y == 0) ? 1 :
               (x == 1 && y == 0) ? 0 :
               (x == 0 && y == 1) ? 0 :
               (x == 1 && y == 1) ? 1 : 1;
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire a1_z, b1_z, a2_z, b2_z;
    wire or_z, and_z;

    A submodule_a1 (
        .x(x),
        .y(y),
        .z(a1_z)
    );

    B submodule_b1 (
        .x(x),
        .y(y),
        .z(b1_z)
    );

    A submodule_a2 (
        .x(x),
        .y(y),
        .z(a2_z)
    );

    B submodule_b2 (
        .x(x),
        .y(y),
        .z(b2_z)
    );

    assign or_z = a1_z | b1_z;
    assign and_z = a2_z & b2_z;
    assign z = or_z ^ and_z;
endmodule
