module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	reg z_internal;

	always @(*) begin
		// Define the logic for z_internal based on the input signals x and y
		if (x && !y)
			z_internal = 1;
		else
			z_internal = 0;
	end

	assign z = z_internal;

endmodule
