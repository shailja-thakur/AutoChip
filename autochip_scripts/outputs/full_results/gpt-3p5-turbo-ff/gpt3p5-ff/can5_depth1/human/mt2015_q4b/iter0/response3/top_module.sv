module top_module(
	input x,
	input y,
	output z
);

	// internal wire to store the value of z
	wire z_internal;
	
	// assign the value of z_internal based on the conditions
	assign z_internal = (x && y) || (x && z) || (y && z);
	
	// assign the value of z to z_internal
	assign z = z_internal;
	
endmodule
