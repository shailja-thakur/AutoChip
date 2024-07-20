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
    wire z1_a, z1_b, z2_a, z2_b;
    wire or_out, and_out;

    A A1 (
        .x(x),
        .y(y),
        .z(z1_a)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(z1_b)
    );

    A A2 (
        .x(x),
        .y(y),
        .z(z2_a)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(z2_b)
    );

    assign or_out = z1_a | z1_b;
    assign and_out = z2_a & z2_b;
    assign z = or_out ^ and_out;
endmodule
