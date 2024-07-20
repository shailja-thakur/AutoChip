module top_module(
    input x,
    input y,
    output z,
    input clk);

    reg z_reg;
    always @(x, y) begin
        z_reg <= x & y;
    end
    
    initial begin
        z_reg = 1'b0;
    end

    always @(posedge clk) begin
        z <= z_reg;
    end
    
endmodule
