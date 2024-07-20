module top_module(
	input x,
	input y,
	output z);

	// Declare internal wires
	wire w1, w2;

	// Perform logic operations
	assign w1 = x ^ y;
	assign w2 = w1 & x;
	
	// Assign the output
	assign z = w2;

endmodule
