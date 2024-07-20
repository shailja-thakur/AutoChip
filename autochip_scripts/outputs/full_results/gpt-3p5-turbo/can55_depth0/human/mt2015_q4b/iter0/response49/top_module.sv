module top_module(
	input x,
	input y,
	output z);

	reg z_reg;

	always @(x, y)
	begin
		if (x == 1'b1 && y == 1'b1)
			z_reg <= 1'b1;
		else
			z_reg <= 1'b0;
	end

	assign z = z_reg;

endmodule
