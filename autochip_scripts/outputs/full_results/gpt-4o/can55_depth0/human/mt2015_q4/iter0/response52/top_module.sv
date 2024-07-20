module A(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B(
    input x,
    input y,
    output reg z
);
    always @(*) begin
        case ({x, y})
            2'b00: z = 1'b1;
            2'b01: z = 1'b0;
            2'b10: z = 1'b0;
            2'b11: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2, z_B1, z_B2;
    wire or_output, and_output;

    // Instantiate two A submodules
    A A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );

    A A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );

    // Instantiate two B submodules
    B B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );

    // First pair: OR gate
    assign or_output = z_A1 | z_B1;

    // Second pair: AND gate
    assign and_output = z_A2 & z_B2;

    // Final XOR gate
    assign z = or_output ^ and_output;
endmodule
