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
            default: z = 1; // default case to handle undesired scenarios
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z1_a, z1_b; // Outputs of the first A and B submodules
    wire z2_a, z2_b; // Outputs of the second A and B submodules
    wire or_out, and_out; // Outputs of the OR and AND gates

    // Instantiate the first pair of A and B submodules
    A u1_A (
        .x(x),
        .y(y),
        .z(z1_a)
    );

    B u1_B (
        .x(x),
        .y(y),
        .z(z1_b)
    );

    // Instantiate the second pair of A and B submodules
    A u2_A (
        .x(x),
        .y(y),
        .z(z2_a)
    );

    B u2_B (
        .x(x),
        .y(y),
        .z(z2_b)
    );

    // Connect the outputs of the first pair to an OR gate
    assign or_out = z1_a | z1_b;

    // Connect the outputs of the second pair to an AND gate
    assign and_out = z2_a & z2_b;

    // Final XOR gate to produce the output z
    assign z = or_out ^ and_out;
endmodule
