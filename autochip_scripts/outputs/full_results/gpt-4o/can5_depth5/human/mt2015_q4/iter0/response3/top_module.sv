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
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_A1, z_A2, z_B1, z_B2;
    wire or_out, and_out;

    // Instantiate the first A and B submodules
    A submodule_A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );

    B submodule_B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );

    // Instantiate the second A and B submodules
    A submodule_A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );

    B submodule_B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );

    // Connect the outputs of the first pair of submodules to an OR gate
    assign or_out = z_A1 | z_B1;

    // Connect the outputs of the second pair of submodules to an AND gate
    assign and_out = z_A2 & z_B2;

    // Connect the outputs of the OR and AND gates to an XOR gate to produce the final output
    assign z = or_out ^ and_out;
endmodule
