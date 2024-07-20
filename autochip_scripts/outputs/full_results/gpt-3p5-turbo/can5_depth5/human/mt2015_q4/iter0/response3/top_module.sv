module a (
    input x,
    input y,
    output z
);

assign z = (x ^ y) & x;

endmodule
module b (
    input x,
    input y,
    output z
);

reg z;

always @(x or y)
begin
    case({x, y})
        2'b00: z = 1;
        2'b01: z = 0;
        2'b10: z = 0;
        2'b11: z = 1;
    endcase
end

assign z = z;

endmodule
module top_module(
    input x,
    input y,
    output z
);

wire a1_z, b1_z, a2_z, b2_z;

a a1(.x(x), .y(y), .z(a1_z));
b b1(.x(x), .y(y), .z(b1_z));
a a2(.x(x), .y(y), .z(a2_z));
b b2(.x(x), .y(y), .z(b2_z));

or2 or_gate(.a(a1_z), .b(b1_z), .z(z));
and2 and_gate(.a(a2_z), .b(b2_z), .z(z));

endmodule
