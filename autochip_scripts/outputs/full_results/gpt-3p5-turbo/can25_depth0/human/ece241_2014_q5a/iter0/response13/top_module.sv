module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg z_reg;
	always @(posedge clk or negedge areset) begin
		if (areset == 0)
			z_reg <= 1'b0;
		else if (x == 1'b1)
			z_reg <= ~z_reg;
	end

	assign z = z_reg;

endmodule
