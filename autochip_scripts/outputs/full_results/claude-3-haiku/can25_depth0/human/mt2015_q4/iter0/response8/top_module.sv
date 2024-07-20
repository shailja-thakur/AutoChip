module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_b1, z_a2, z_b2;

module_a a1 (
    .x(x),
    .y(y),
    .z(z_a1)
);

module_a a2 (
    .x(x),
    .y(y),
    .z(z_a2)
);

module_b b1 (
    .x(x),
    .y(y),
    .z(z_b1)
);

module_b b2 (
    .x(x),
    .y(y),
    .z(z_b2)
);

assign z = (z_a1 | z_b1) ^ (z_a2 & z_b2);

endmodule
module module_a(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module module_b(
    input x,
    input y,
    output z
);

reg z;

always @(*) begin
    case ({x, y})
        2'b00: z = 1'b1;
        2'b01: z = 1'b0;
        2'b10: z = 1'b0;
        2'b11: z = 1'b1;
    endcase
end

endmodule
