module top_module(
	input x,
	input y,
	output z);

	// Define internal signal
	wire z_temp;

	// Assign statements for internal signal
	assign z_temp = (x & y) | (x & ~y);

	// Output assignment
	assign z = z_temp;

endmodule
