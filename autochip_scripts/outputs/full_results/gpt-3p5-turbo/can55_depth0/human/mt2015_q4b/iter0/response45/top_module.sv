module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	reg x_reg;
	reg y_reg;
	reg z_reg;

	always @(x, y)
	begin
		// Shift input x and y into registers
		x_reg <= x;
		y_reg <= y;

		// Calculate output z based on the values in the registers
		if (x_reg == 1'b1 && y_reg == 1'b1)
			z_reg <= 1'b1;
		else
			z_reg <= 1'b0;
	end

	assign z = z_reg;

endmodule
