module top_module(
	input x,
	input y,
	output z);

	// Internal wires
	wire z_int;

	// D flip-flop for z
	reg z_reg;

	// Logic to compute z
	always @(x, y) begin
		if (x & y)
			z_int <= 1'b1;
		else
			z_int <= 1'b0;
	end

	// D flip-flop for z
	always @(posedge clk) begin
		z_reg <= z_int;
	end

	// Output assignment for z
	assign z = z_reg;

endmodule
