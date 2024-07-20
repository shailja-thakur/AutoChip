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
            default: z = 0;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_B1, z_A2, z_B2;
    wire or_out, and_out;

    // Instantiate first pair of A and B submodules
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

    // OR gate for first pair of submodules
    assign or_out = z_A1 | z_B1;

    // Instantiate second pair of A and B submodules
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

    // AND gate for second pair of submodules
    assign and_out = z_A2 & z_B2;

    // XOR gate for the final output
    assign z = or_out ^ and_out;
endmodule
