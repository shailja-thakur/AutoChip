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
    // Internal wire to hold the current state of z
    reg z_reg;
    
    always @(x or y) begin
        case ({x, y})
            2'b00: z_reg = 1'b1;
            2'b01: z_reg = 1'b0;
            2'b10: z_reg = 1'b0;
            2'b11: z_reg = 1'b1;
            default: z_reg = 1'b0;
        endcase
    end
    
    assign z = z_reg;
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire zA1, zA2, zB1, zB2;
    wire z_or, z_and;
    
    // Instantiate submodules
    A A1 (.x(x), .y(y), .z(zA1));
    B B1 (.x(x), .y(y), .z(zB1));
    A A2 (.x(x), .y(y), .z(zA2));
    B B2 (.x(x), .y(y), .z(zB2));
    
    // OR gate
    assign z_or = zA1 | zB1;
    
    // AND gate
    assign z_and = zA2 & zB2;

    // XOR gate
    assign z = z_or ^ z_and;
endmodule
