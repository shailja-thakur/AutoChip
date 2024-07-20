module top_module(
    input x,
    input y,
    output z
);

// Submodules
wire z1, z2;

module_A submodule_A1 (
    .x(x),
    .y(y),
    .z(z1)
);

module_A submodule_A2 (
    .x(x),
    .y(y),
    .z(z2)
);

module_B submodule_B1 (
    .x(x),
    .y(y),
    .z(z1)
);

module_B submodule_B2 (
    .x(x),
    .y(y),
    .z(z2)
);

// Top-level logic
wire or_out, and_out;
assign or_out = z1 | z1;
assign and_out = z2 & z2;
assign z = or_out ^ and_out;

endmodule
module module_A (
    input x,
    input y,
    output z
);
assign z = (x ^ y) & x;
endmodule
module module_B (
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
