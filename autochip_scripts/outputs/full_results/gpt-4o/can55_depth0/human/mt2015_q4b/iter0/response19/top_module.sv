module top_module(
    input x,
    input y,
    output z);

    reg z_reg;

    assign z = z_reg;

    always @(*) begin
        if (x && y) begin
            z_reg = 1;
        end else if (x && !y) begin
            z_reg = 0;
        end else if (!x && y) begin
            z_reg = 0;
        end else begin
            z_reg = 1;
        end
    end

endmodule
