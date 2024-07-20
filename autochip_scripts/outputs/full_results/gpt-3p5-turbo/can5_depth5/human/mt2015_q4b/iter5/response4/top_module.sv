module top_module(
    input x,
    input y,
	output z
);

    reg z_reg;
    
    assign z = z_reg;

    always @ (x or y) begin
        z_reg <= x & y;
    end

endmodule
