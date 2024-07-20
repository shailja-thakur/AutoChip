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
    reg z;
    always @* begin
        if (x == 0 && y == 0)
            z = 1;
        else if (x == 1 && y == 0)
            z = 0;
        else if (x == 0 && y == 1)
            z = 0;
        else if (x == 1 && y == 1)
            z = 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zB1, zA2, zB2;
    wire or_result, and_result;

    // Instantiate two modules of A
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

    // Instantiate two modules of B
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

    // OR gate for the outputs of the first pair of modules (A and B)
    assign or_result = zA1 | zB1;

    // AND gate for the outputs of the second pair of modules (A and B)
    assign and_result = zA2 & zB2;

    // XOR gate for the outputs of the OR result and the AND result
    assign z = or_result ^ and_result;
endmodule
