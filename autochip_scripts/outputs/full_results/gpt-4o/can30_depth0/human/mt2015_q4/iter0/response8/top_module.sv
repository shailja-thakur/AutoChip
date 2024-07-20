module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input x,
    input y,
    output z
);
    reg z_reg;
    always @(*) begin
        case ({x, y})
            2'b00: z_reg = 1;
            2'b01: z_reg = 0;
            2'b10: z_reg = 0;
            2'b11: z_reg = 1;
            default: z_reg = 0;
        endcase
    end
    assign z = z_reg;
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire z_a1, z_b1, z_a2, z_b2;
    wire or_out, and_out;

    A submod_a1 (.x(x), .y(y), .z(z_a1));
    B submod_b1 (.x(x), .y(y), .z(z_b1));
    A submod_a2 (.x(x), .y(y), .z(z_a2));
    B submod_b2 (.x(x), .y(y), .z(z_b2));

    assign or_out = z_a1 | z_b1;
    assign and_out = z_a2 & z_b2;
    assign z = or_out ^ and_out;
endmodule
