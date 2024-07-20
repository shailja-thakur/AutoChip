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
wire z_A1, z_A2, z_B1, z_B2;

module_A A1(
    .x(x),
    .y(y),
    .z(z_A1)
);

module_A A2(
    .x(x),
    .y(y),
    .z(z_A2)
);

module_B B1(
    .x(x),
    .y(y),
    .z(z_B1)
);

module_B B2(
    .x(x),
    .y(y),
    .z(z_B2)
);

wire or_out, and_out;
assign or_out = z_A1 | z_B1;
assign and_out = z_A2 & z_B2;
assign z = or_out ^ and_out;
endmodule
