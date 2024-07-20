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
    wire zA1, zA2, zB1, zB2;
    wire or_out, and_out;

    // Instantiate first A and B modules
    A a1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    // Instantiate second A and B modules
    A a2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    // OR gate for first pair of A and B
    assign or_out = zA1 | zB1;

    // AND gate for second pair of A and B
    assign and_out = zA2 & zB2;

    // XOR gate for OR and AND outputs
    assign z = or_out ^ and_out;

endmodule
