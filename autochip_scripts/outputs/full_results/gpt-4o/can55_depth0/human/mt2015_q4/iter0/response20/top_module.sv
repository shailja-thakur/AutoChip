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
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 1'bx; // unknown case
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_B1;
    wire z_A2, z_B2;
    wire z_or, z_and;

    // Instantiation of first pair of A and B submodules
    A A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );

    // OR gate connecting outputs of first pair
    assign z_or = z_A1 | z_B1;

    // Instantiation of second pair of A and B submodules
    A A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );

    // AND gate connecting outputs of second pair
    assign z_and = z_A2 & z_B2;

    // XOR gate combining the OR and AND gate outputs
    assign z = z_or ^ z_and;
endmodule
