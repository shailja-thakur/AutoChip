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
assign z = (x & y) | (!x & !y);
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_out, and_out;

    // Instantiate the first pair of A and B
    A A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    // Instantiate the second pair of A and B
    A A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    // OR gate for the first pair of outputs
    assign or_out = zA1 | zB1;

    // AND gate for the second pair of outputs
    assign and_out = zA2 & zB2;

    // XOR gate for the final output
    assign z = or_out ^ and_out;

endmodule
