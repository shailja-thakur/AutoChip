module ModuleA(
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
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

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire z1, z2, z3, z4;

ModuleA A1(
    .x(x),
    .y(y),
    .z(z1)
);

ModuleA A2(
    .x(x),
    .y(y),
    .z(z2)
);

ModuleB B1(
    .x(x),
    .y(y),
    .z(z3)
);

ModuleB B2(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z3) ^ (z2 & z4);

endmodule
