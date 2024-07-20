module top_module(
    input x,
    input y,
    output z);
    
    reg z_reg;
    
    always @(*) begin
        if (x == 1'b1 && y == 1'b1) begin
            z_reg = 1'b1;
        end else if (x == 1'b0 && y == 1'b0) begin
            z_reg = 1'b1;
        end else if (x == 1'b1 && y == 1'b0) begin
            z_reg = 1'b0;
        end else if (x == 1'b0 && y == 1'b1) begin
            z_reg = 1'b0;
        end
    end

    assign z = z_reg;

endmodule
