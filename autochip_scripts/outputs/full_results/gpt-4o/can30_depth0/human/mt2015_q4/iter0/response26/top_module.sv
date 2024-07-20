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
    wire z1_A, z1_B, z2_A, z2_B;
    wire or_out, and_out;

    A A1 (
        .x(x),
        .y(y),
        .z(z1_A)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(z1_B)
    );

    A A2 (
        .x(x),
        .y(y),
        .z(z2_A)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(z2_B)
    );

    assign or_out = z1_A | z1_B;
    assign and_out = z2_A & z2_B;
    assign z = or_out ^ and_out;

endmodule
