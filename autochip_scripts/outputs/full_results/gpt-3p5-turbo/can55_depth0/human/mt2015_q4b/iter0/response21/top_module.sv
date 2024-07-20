module top_module(
    input x,
    input y,
    output z);

    reg x_reg, y_reg, z_reg;

    always @(x or y)
    begin
        x_reg <= x;
        y_reg <= y;
        if(x_reg && y_reg)
            z_reg <= 1;
        else
            z_reg <= 0;
    end
    
    assign z = z_reg;

endmodule
