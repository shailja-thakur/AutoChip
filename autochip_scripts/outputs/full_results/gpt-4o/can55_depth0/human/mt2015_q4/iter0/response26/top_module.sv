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
    reg z_reg;
    assign z = z_reg;

    always @(x or y) begin
        case ({x, y})
            2'b00: z_reg = 1;
            2'b01: z_reg = 0;
            2'b10: z_reg = 0;
            2'b11: z_reg = 1;
            default: z_reg = 1;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2;
    wire z_B1, z_B2;
    wire or_output, and_output;

    // Instantiate the first A submodule
    A A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );

    // Instantiate the first B submodule
    B B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );

    // Instantiate the second A submodule
    A A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );

    // Instantiate the second B submodule
    B B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );

    // OR gate with outputs from the first pair of A and B submodules
    assign or_output = z_A1 | z_B1;

    // AND gate with outputs from the second pair of A and B submodules
    assign and_output = z_A2 & z_B2;

    // XOR gate with outputs from the OR and AND gates
    assign z = or_output ^ and_output;
endmodule
