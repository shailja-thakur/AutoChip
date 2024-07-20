module A_module(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B_module(
    input x,
    input y,
    output z
);
    assign z = (x == 0 && y != 0) ? 0 : 1;
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire A1_out, B1_out;
    wire A2_out, B2_out;
    wire or_out, and_out;

    A_module A1 (
        .x(x),
        .y(y),
        .z(A1_out)
    );

    B_module B1 (
        .x(x),
        .y(y),
        .z(B1_out)
    );

    assign or_out = A1_out | B1_out;

    A_module A2 (
        .x(x),
        .y(y),
        .z(A2_out)
    );

    B_module B2 (
        .x(x),
        .y(y),
        .z(B2_out)
    );

    assign and_out = A2_out & B2_out;

    assign z = or_out ^ and_out;
endmodule
