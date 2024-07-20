module top_module(
	input x,
	input y,
	output z);

	always @(x or y) begin
		if (x && y) begin
			z = 1;
		end else begin
			z = 0;
		end
	end

endmodule
