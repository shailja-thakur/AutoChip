module module_A(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module module_B(
    input x,
    input y,
    output z
);

reg z;

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

wire z1, z2, z3, z4;

module_A submodule_A1(
    .x(x),
    .y(y),
    .z(z1)
);

module_B submodule_B1(
    .x(x),
    .y(y),
    .z(z2)
);

module_A submodule_A2(
    .x(x),
    .y(y),
    .z(z3)
);

module_B submodule_B2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z2) ^ (z3 & z4);

endmodule
