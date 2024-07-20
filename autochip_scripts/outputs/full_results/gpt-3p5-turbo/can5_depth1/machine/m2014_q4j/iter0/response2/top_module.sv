module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
  
	// Declaration of internal wire for carry bit
	wire carry;
  
	// Assign the sum of x and y to sum, with the carry bit as the most significant bit
	assign {carry, sum[3:0]} = x + y;
  
endmodule
