module A(
    input x,
    input y,
    output z);

    assign z = (x ^ y) & x;

endmodule
module B(
    input x,
    input y,
    output z);

    assign #5 z = x & y;

endmodule
module top_module(
    input x,
    input y,
    output z);

    wire a_out1, a_out2, b_out1, b_out2;

    A a1 (
        .x(x),
        .y(y),
        .z(a_out1)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(b_out1)
    );

    A a2 (
        .x(x),
        .y(y),
        .z(a_out2)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(b_out2)
    );

    wire or_output;
    wire and_output;

    assign or_output = a_out1 | b_out1;
    assign and_output = a_out2 & b_out2;
    assign z = xor(or_output, and_output);

endmodule
