module top_module(
	input x,
	input y,
	output z);

	/* Define internal signal */
	reg z_internal;

	/* Assign statements for internal signal */
	always @(x, y)
	begin
		if (x == 1'b1 && y == 1'b0)
			z_internal = 1'b1;
		else if (x == 1'b0 && y == 1'b1)
			z_internal = 1'b0;
		else
			z_internal = 1'b0;
	end

	/* Assign statements for output */
	assign z = z_internal;

endmodule
