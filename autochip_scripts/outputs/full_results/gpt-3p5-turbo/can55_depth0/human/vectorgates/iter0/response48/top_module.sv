module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);
	// Compute the bitwise-OR of a and b
	assign out_or_bitwise = a | b;
	
	// Compute the logical-OR of a and b
	assign out_or_logical = |(a | b);
	
	// Compute the inverse of b and place it in the upper half of out_not
	assign out_not[5:3] = ~b;
	
	// Compute the inverse of a and place it in the lower half of out_not
	assign out_not[2:0] = ~a;
endmodule
