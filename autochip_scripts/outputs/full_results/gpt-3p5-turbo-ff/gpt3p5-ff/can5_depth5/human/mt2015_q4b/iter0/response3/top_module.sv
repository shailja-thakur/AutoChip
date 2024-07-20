module top_module(
	input x,
	input y,
	output z);

	// declare internal signal
	reg z_internal;

	always @(x, y) begin
		if (x && y) begin
			z_internal <= 1;
		end else begin
			z_internal <= 0;
		end
	end

	assign z = z_internal;

endmodule
