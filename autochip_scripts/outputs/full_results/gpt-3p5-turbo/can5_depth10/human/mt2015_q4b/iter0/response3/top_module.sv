module top_module(
	input x,
	input y,
	output z);

	always @(x, y) begin
		if (x && y)
			z = 1;
		else if (x || y)
			z = 0;
		else
			z = 1;
	end

endmodule
