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
    always @(*)
    begin
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

    wire a1_out, a2_out, b1_out, b2_out;
    wire or_out, and_out;

    // Instantiate the first pair of A and B submodules
    A u1_A (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    B u1_B (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    // Instantiate the second pair of A and B submodules
    A u2_A (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    B u2_B (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR Gate for the first pair's outputs
    assign or_out = a1_out | b1_out;

    // AND Gate for the second pair's outputs
    assign and_out = a2_out & b2_out;

    // XOR Gate for the final output
    assign z = or_out ^ and_out;

endmodule
