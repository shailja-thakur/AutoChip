module top_module(
	input x,
	input y,
	output z);

	// Add missing semicolon at the end of the module declaration

	// Combinational logic
	assign z = (x ^ y) & x;

endmodule
