module A(
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B(
    input x,
    input y,
    output z
);
    reg z_reg;
    assign z = z_reg;
    
    always @(*) begin
        case ({x, y})
            2'b00: z_reg = 1;
            2'b01: z_reg = 0;
            2'b10: z_reg = 0;
            2'b11: z_reg = 1;
            default: z_reg = 1;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire or_out, and_out;

    A u1 (.x(x), .y(y), .z(zA1));
    A u2 (.x(x), .y(y), .z(zA2));
    B u3 (.x(x), .y(y), .z(zB1));
    B u4 (.x(x), .y(y), .z(zB2));

    assign or_out = zA1 | zB1;
    assign and_out = zA2 & zB2;
    assign z = or_out ^ and_out;
endmodule
