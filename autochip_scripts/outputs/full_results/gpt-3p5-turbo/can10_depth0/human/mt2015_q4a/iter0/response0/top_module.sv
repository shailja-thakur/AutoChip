module top_module(
	input x,
	input y,
	output z);

	/*wire a, b, c; // intermediate signals*/

	// Assign intermediate signals
	//assign a = x ^ y;
	//assign b = a & x;
	//assign z = b;
	
	// Implement the boolean function z = (x^y) & x
	assign z = (x^y) & x;

endmodule
