module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input x,
    input y,
    output z
);
    assign z = ((x == 0) && (y == 0)) || ((x == 1) && (y == 1));
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_output, and_output;

    A a1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    A a2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    assign or_output = zA1 | zB1;
    assign and_output = zA2 & zB2;
    assign z = or_output ^ and_output;
endmodule
