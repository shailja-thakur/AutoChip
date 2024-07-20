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
               (x == 1 && y == 1) ? 1 : 0;
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_a1, z_b1, z_a2, z_b2;
    wire or_output, and_output;

    A a1 (
        .x(x),
        .y(y),
        .z(z_a1)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(z_b1)
    );

    A a2 (
        .x(x),
        .y(y),
        .z(z_a2)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(z_b2)
    );

    assign or_output = z_a1 | z_b1;
    assign and_output = z_a2 & z_b2;
    assign z = or_output ^ and_output;
endmodule
