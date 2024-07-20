module top_module(
	input x,
	input y,
	output z);

	// Declare internal signal
	reg z_reg;

	// Sequential logic
	always @(posedge x or posedge y) begin
		if (x & ~y) // Condition1
			z_reg <= 1'b0;
		else if (~x & y) // Condition2
			z_reg <= 1'b1;
	end

	// Assign output
	assign z = z_reg;

endmodule
