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
    wire z1_A, z1_B, z2_A, z2_B;
    wire or_output, and_output;

    A A1 (
        .x(x),
        .y(y),
        .z(z1_A)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(z1_B)
    );

    A A2 (
        .x(x),
        .y(y),
        .z(z2_A)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(z2_B)
    );

    assign or_output = z1_A | z1_B;
    assign and_output = z2_A & z2_B;
    assign z = or_output ^ and_output;
endmodule
