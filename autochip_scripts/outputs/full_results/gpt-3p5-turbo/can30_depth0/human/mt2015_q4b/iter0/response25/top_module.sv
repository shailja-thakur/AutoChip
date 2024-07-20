module top_module(
    input x,
    input y,
    output reg z);

    reg z_reg;

    always @(*)
    begin
        case({x, y})
            2'b00: z_reg <= 1'b1;
            2'b01: z_reg <= 1'b1;
            2'b10: z_reg <= 1'b0;
            2'b11: z_reg <= z_reg;
        endcase
    end

    assign z = z_reg;

endmodule
