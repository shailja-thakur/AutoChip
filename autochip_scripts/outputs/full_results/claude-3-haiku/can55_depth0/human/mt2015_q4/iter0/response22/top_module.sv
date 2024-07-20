module top_module(
    input x,
    input y,
    output z
);

wire z1, z2;

module_a first_a(
    .x(x),
    .y(y),
    .z(z1)
);

module_b first_b(
    .x(x),
    .y(y),
    .z(z1)
);

module_a second_a(
    .x(x),
    .y(y),
    .z(z2)
);

module_b second_b(
    .x(x),
    .y(y),
    .z(z2)
);

assign z = (z1 | z2) ^ (z1 & z2);

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
