module top_module(
    input x,
    input y,
    output z);

    reg x_reg;
    reg y_reg;
    wire z_wire;

    always @(x)
        x_reg <= x;
    
    always @(y)
        y_reg <= y;

    assign z_wire = x_reg & ~y_reg;

    assign z = z_wire;

endmodule
