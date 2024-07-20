module top_module(
    input x,
    input y,
    output z);

    reg z_reg;

    always @(*) begin
        if (x == 0 && y == 0) begin
            z_reg = 1;
        end else if (x == 1 && y == 0) begin
            z_reg = 0;
        end else if (x == 0 && y == 1) begin
            z_reg = 0;
        end else if (x == 1 && y == 1) begin
            z_reg = 1;
        end else begin
            z_reg = 1'bx; // undefined condition
        end
    end

    assign z = z_reg;

endmodule
