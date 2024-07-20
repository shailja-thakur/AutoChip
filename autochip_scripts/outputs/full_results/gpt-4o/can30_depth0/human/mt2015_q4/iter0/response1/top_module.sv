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
            default: z = 1;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);

    wire zA1, zA2, zB1, zB2;
    wire or_out, and_out;

    // Instantiate the first A and B submodules
    A A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    // Instantiate the second A and B submodules
    A A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    // OR gate combining outputs of A1 and B1
    assign or_out = zA1 | zB1;

    // AND gate combining outputs of A2 and B2
    assign and_out = zA2 & zB2;

    // XOR gate combining outputs of OR and AND gates
    assign z = or_out ^ and_out;

endmodule
