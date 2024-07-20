module top_module(
	input x,
	input y,
	output z);

	// Declare internal signal
	reg z_internal;

	always @(*) begin
		if (x && y)
			z_internal = 1;
		else if (x || y)
			z_internal = 0;
		else
			z_internal = 1;
	end

	assign z = z_internal;

endmodule
