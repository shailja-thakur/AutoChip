module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_b1, z_a2, z_b2;

// Submodule A implementation
module_A A1 (
    .x(x),
    .y(y),
    .z(z_a1)
);

module_A A2 (
    .x(x),
    .y(y),
    .z(z_a2)
);

// Submodule B implementation
module_B B1 (
    .x(x),
    .y(y),
    .z(z_b1)
);

module_B B2 (
    .x(x),
    .y(y),
    .z(z_b2)
);

// Top-level logic
wire or_out, and_out;
or(or_out, z_a1, z_b1);
and(and_out, z_a2, z_b2);
xor(z, or_out, and_out);

endmodule
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
    case({x,y})
        2'b00: z = 1'b1;
        2'b01: z = 1'b0;
        2'b10: z = 1'b0;
        2'b11: z = 1'b1;
    endcase
end
endmodule
