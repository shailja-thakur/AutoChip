module ModuleA (
    input x,
    input y,
    output reg z
);

always @(*) begin
    z = (x ^ y) & x;
end

endmodule
module ModuleB (
    input x,
    input y,
    output reg z
);

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

wire z_a1, z_b1, z_a2, z_b2, z_or, z_and;

ModuleA a1 (.x(x), .y(y), .z(z_a1));
ModuleB b1 (.x(x), .y(y), .z(z_b1));
ModuleA a2 (.x(x), .y(y), .z(z_a2));
ModuleB b2 (.x(x), .y(y), .z(z_b2));

assign z_or = z_a1 | z_b1;
assign z_and = z_a2 & z_b2;
assign z = z_or ^ z_and;

endmodule
