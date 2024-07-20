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
  
    assign z = #0 20;
    assign z = #25 x & y;

endmodule
module top_module(
    input x,
    input y,
    output z
);

    wire a_output;
    wire b_output;
    wire or_output;
    wire and_output;

    A a1 (
        .x(x),
        .y(y),
        .z(a_output)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(b_output)
    );

    A a2 (
        .x(x),
        .y(y),
        .z(a_output)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(b_output)
    );

    assign or_output = a_output | b_output;
    assign and_output = a_output & b_output;
    assign z = or_output ^ and_output;

endmodule
