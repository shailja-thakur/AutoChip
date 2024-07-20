module top_module(
    input x,
    input y,
    output z);

    reg z_reg;
    always @(x, y) begin
        z_reg <= x & y;
    end
    
    // Add initial statement to initialize z_reg
    initial begin
        z_reg = 1'b0;
    end
    
    assign z = z_reg;
    
endmodule
