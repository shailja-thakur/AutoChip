module moduleA (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module moduleB (
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

    moduleA u_A1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    moduleB u_B1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    moduleA u_A2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    moduleB u_B2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    assign or_out = zA1 | zB1;
    assign and_out = zA2 & zB2;
    assign z = or_out ^ and_out;
endmodule
