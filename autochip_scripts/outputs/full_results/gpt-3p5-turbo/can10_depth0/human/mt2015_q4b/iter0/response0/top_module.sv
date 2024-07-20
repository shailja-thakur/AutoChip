module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	reg z_internal;

	// Assign output
	assign z = z_internal;

	// State machine
	always @ (x, y)
	begin
		if (x && y)
			z_internal = 1;
		else
			z_internal = 0;
	end

endmodule
