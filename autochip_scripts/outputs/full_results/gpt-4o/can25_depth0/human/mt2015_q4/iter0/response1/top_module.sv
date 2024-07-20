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
    output reg z
);
    always @(*) begin
        if (x == 0 && y == 0)
            z <= 1;
        else if (x == 1 && y == 0)
            z <= 0;
        else if (x == 0 && y == 1)
            z <= 0;
        else if (x == 1 && y == 1)
            z <= 1;
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);

    wire z1_A, z2_A, z1_B, z2_B;
    wire or_out, and_out;

    // Instantiate first A submodule
    A inst1_A (
        .x(x),
        .y(y),
        .z(z1_A)
    );

    // Instantiate first B submodule
    B inst1_B (
        .x(x),
        .y(y),
        .z(z1_B)
    );

    // Instantiate second A submodule
    A inst2_A (
        .x(x),
        .y(y),
        .z(z2_A)
    );

    // Instantiate second B submodule
    B inst2_B (
        .x(x),
        .y(y),
        .z(z2_B)
    );

    // Connect output of first A and B to OR gate
    assign or_out = z1_A | z1_B;

    // Connect output of second A and B to AND gate
    assign and_out = z2_A & z2_B;

    // Connect outputs of OR and AND gates to XOR gate
    assign z = or_out ^ and_out;

endmodule
