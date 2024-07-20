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
    wire z_A1, z_B1, z_A2, z_B2;
    wire or_output, and_output;

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

    assign or_output = z_A1 | z_B1;
    assign and_output = z_A2 & z_B2;

    assign z = or_output ^ and_output;
endmodule
