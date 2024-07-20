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
    always @(x or y) begin
        case ({x, y})
            2'b00: z <= 1;
            2'b01: z <= 0;
            2'b10: z <= 0;
            2'b11: z <= 1;
            default: z <= 0;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zB1, zA2, zB2;
    wire or_result, and_result;

    // First pair of A and B submodules
    A submodule_A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    B submodule_B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    assign or_result = zA1 | zB1;

    // Second pair of A and B submodules
    A submodule_A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    B submodule_B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    assign and_result = zA2 & zB2;

    // XOR the results of OR and AND gates
    assign z = or_result ^ and_result;

endmodule
