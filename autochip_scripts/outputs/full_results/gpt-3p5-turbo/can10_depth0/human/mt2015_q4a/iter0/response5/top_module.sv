module top_module(
	input x,
	input y,
	output z);
	
	// Declare internal wire
	wire temp;

	// Implement the boolean function
	assign temp = x ^ y;
	assign z = temp & x;
endmodule
