module top_module(
    input x,
    input y,
    output z);

    reg x_reg;
    reg y_reg;
    wire z_wire;

    always @(posedge x or posedge y) begin
        x_reg <= x;
        y_reg <= y;
    end

    assign z_wire = x_reg & y_reg;
    assign z = z_wire;
endmodule
