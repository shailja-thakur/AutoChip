module top_module(
	input x,
	input y,
	output z);
	
	// wire to hold the intermediate result of x^y
	wire x_xor_y;
	
	// assign the value of x^y to x_xor_y
	assign x_xor_y = x ^ y;
	
	// assign the value of z to be (x^y) & x
	assign z = x_xor_y & x;
	
endmodule
