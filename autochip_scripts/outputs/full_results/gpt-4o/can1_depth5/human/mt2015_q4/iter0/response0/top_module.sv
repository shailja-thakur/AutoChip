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
module top_module (
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire zOR, zAND;

    A uA1 (
        .x(x),
        .y(y),
        .z(zA1)
    );

    A uA2 (
        .x(x),
        .y(y),
        .z(zA2)
    );

    B uB1 (
        .x(x),
        .y(y),
        .z(zB1)
    );

    B uB2 (
        .x(x),
        .y(y),
        .z(zB2)
    );

    assign zOR = zA1 | zB1;
    assign zAND = zA2 & zB2;
    assign z = zOR ^ zAND;
endmodule
