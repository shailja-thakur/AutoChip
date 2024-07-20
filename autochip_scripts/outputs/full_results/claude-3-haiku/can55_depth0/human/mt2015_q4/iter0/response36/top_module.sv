module moduleA(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module moduleB(
    input x,
    input y,
    output z
);

reg z;

always @(x, y) begin
    case ({x, y})
        2'b00, 2'b01, 2'b10: z = 1'b1;
        2'b11: z = 1'b0;
        default: z = 1'bx;
    endcase
end

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3, z4;

moduleA a1(
    .x(x),
    .y(y),
    .z(z1)
);

moduleA a2(
    .x(x),
    .y(y),
    .z(z2)
);

moduleB b1(
    .x(x),
    .y(y),
    .z(z3)
);

moduleB b2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z3) ^ (z2 & z4);

endmodule
