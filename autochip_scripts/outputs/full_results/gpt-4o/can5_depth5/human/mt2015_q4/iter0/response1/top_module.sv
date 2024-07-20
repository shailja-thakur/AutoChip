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
    wire zA1, zB1, zA2, zB2;
    wire or_out, and_out;

    // Instantiate first A and B submodules
    A A1(
        .x(x),
        .y(y),
        .z(zA1)
    );

    B B1(
        .x(x),
        .y(y),
        .z(zB1)
    );

    // Instantiate second A and B submodules
    A A2(
        .x(x),
        .y(y),
        .z(zA2)
    );

    B B2(
        .x(x),
        .y(y),
        .z(zB2)
    );

    // OR gate
    assign or_out = zA1 | zB1;

    // AND gate
    assign and_out = zA2 & zB2;

    // XOR gate (outputs final z)
    assign z = or_out ^ and_out;
endmodule
