module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	reg z_internal;
	
	// Assign signal z_internal based on input values x and y
	always @(x, y)
		begin
			if (x == 1'b1)
				z_internal <= 1'b0;
			else if (y == 1'b1)
				z_internal <= 1'b0;
			else
				z_internal <= 1'b1;
		end
	
	// Assign output z to z_internal
	assign z = z_internal;

endmodule
