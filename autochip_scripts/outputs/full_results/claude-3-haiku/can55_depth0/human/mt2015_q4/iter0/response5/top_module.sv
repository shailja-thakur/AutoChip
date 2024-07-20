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

always @(x, y) begin
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

module_A inst1(
    .x(x),
    .y(y),
    .z(z1)
);

module_B inst2(
    .x(x),
    .y(y),
    .z(z2)
);

module_A inst3(
    .x(x),
    .y(y),
    .z(z3)
);

module_B inst4(
    .x(x),
    .y(y),
    .z(z4)
);

assign z = (z1 | z2) ^ (z3 & z4);

endmodule
