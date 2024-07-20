module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	reg z_internal;

	// Assign value to internal signal z_internal based on inputs x and y
	always @ (x, y)
	begin
		if (x == 1'b1 || y == 1'b1)
			z_internal = 1'b1;
		else
			z_internal = 1'b0;
	end

	// Assign value of internal signal z_internal to output z
	assign z = z_internal;

endmodule
