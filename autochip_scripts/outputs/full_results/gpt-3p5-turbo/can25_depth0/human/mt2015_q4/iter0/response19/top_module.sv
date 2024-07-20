module top_module(
	input x,
	input y,
	output z);

	// Define A module
	module A(
		input x,
		input y,
		output z);
	
		assign z = (x ^ y) & x;
	endmodule
module B(
		input x,
		input y,
		output z);
	
		assign z = #0 (x & y) | !y;
	endmodule
