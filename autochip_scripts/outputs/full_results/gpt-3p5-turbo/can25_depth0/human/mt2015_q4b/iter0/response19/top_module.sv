module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	reg z_reg;

	// Set initial values for signals
	initial begin
		z_reg = 1'b0;
	end

	// Assign value to output z based on input x and y
	always @(x or y) begin
		if (x & !y)
			z_reg <= 1'b0;
		else if (x | y)
			z_reg <= 1'b1;
	end

	// Assign signal value to output
	assign z = z_reg;

endmodule
