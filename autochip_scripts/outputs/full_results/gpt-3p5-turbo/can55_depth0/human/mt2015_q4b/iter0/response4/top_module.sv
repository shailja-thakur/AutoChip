module top_module(
	input x,
	input y,
	output z);

	// Use reg keyword to declare flip-flops for x, y, and z
	reg x_ff;
	reg y_ff;
	reg z_ff;

	// Use always@(posedge clk) to describe the sequential logic
	always@(posedge clk) begin
		x_ff <= x;
		y_ff <= y;

		if (x_ff && y_ff)
			z_ff <= 1;
		else
			z_ff <= 0;
	end

	// Assign the output z to the value of z_ff
	assign z = z_ff;

endmodule
