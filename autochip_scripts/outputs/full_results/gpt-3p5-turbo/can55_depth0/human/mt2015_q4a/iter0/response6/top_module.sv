module top_module(
	input x,
	input y,
	output z);

	// Declare internal wire
	wire w1;

	// Assign internal wire with XOR operation
	assign w1 = x ^ y;

	// Assign output with AND operation
	assign z = w1 & x;

endmodule
