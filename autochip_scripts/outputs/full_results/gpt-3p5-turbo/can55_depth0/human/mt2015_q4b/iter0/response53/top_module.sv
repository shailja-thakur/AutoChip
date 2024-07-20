module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	reg z_reg;

	always @(x, y) begin
		if (x == 1'b1 && y == 1'b1) begin
			z_reg <= 1'b1;
		end else begin
			z_reg <= 1'b0;
		end
	end

	assign z = z_reg;

endmodule
