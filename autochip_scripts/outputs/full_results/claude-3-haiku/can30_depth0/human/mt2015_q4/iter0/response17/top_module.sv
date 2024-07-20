module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_a2, z_b1, z_b2;

module_a u_a1 (
    .x(x),
    .y(y),
    .z(z_a1)
);

module_a u_a2 (
    .x(x),
    .y(y),
    .z(z_a2)
);

module_b u_b1 (
    .x(x),
    .y(y),
    .z(z_b1)
);

module_b u_b2 (
    .x(x),
    .y(y),
    .z(z_b2)
);

or u_or (
    .a(z_a1),
    .b(z_b1),
    .y(z_or)
);

and u_and (
    .a(z_a2),
    .b(z_b2),
    .y(z_and)
);

xor u_xor (
    .a(z_or),
    .b(z_and),
    .y(z)
);

endmodule
module module_a (
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module module_b (
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
