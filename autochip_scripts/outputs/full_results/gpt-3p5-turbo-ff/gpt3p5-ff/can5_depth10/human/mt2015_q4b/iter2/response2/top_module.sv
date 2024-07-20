module top_module(
    input x,
    input y,
    output z);

    // Add a delay to the output z
    reg z_reg;
    always @(x, y) begin
        #10;
        z_reg <= x & y;
    end
    assign z = z_reg;

endmodule
