module ModuleA(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

module ModuleB(
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

module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3, z4;

ModuleA mod_a1(
    .x(x),
    .y(y),
    .z(z1)
);

ModuleA mod_a2(
    .x(x),
    .y(y),
    .z(z2)
);

ModuleB mod_b1(
    .x(x),
    .y(y),
    .z(z3)
);

ModuleB mod_b2(
    .x(x),
    .y(y),
    .z(z4)
);

wire or_out, and_out;
assign or_out = z1 | z3;
assign and_out = z2 & z4;
assign z = or_out ^ and_out;

endmodule
