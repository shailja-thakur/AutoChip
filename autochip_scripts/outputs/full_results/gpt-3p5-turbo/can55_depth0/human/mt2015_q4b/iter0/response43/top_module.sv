module top_module(
	input x,
	input y,
	output z);

	// Declare a wire to store the value of z
	wire z;

	// Implement the logic for z
	assign z = (x & y);

endmodule
