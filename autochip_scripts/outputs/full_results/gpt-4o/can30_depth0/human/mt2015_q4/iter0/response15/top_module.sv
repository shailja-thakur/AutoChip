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
    assign z = (x & y) | (~x & ~y);
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_output, and_output;

    // Instantiate two A submodules
    A A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );
    A A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    // Instantiate two B submodules
    B B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );
    B B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    // OR gate for the outputs of the first pair of A and B submodules
    assign or_output = zA1 | zB1;

    // AND gate for the outputs of the second pair of A and B submodules
    assign and_output = zA2 & zB2;

    // XOR gate for the outputs of the OR and AND gates
    assign z = or_output ^ and_output;
endmodule
