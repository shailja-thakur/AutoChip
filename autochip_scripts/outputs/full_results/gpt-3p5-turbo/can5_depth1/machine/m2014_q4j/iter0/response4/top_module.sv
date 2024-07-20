module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	
	// Declare internal wires
	wire [4:0] sum_temp;
	wire carry;
	
	// Adder logic
	// Assign the sum_temp to the sum of x and y
	// The most significant bit of sum_temp will be the carry bit
	assign sum_temp = x + y;
	
	// Assign the carry bit to the most significant bit of sum_temp
	assign carry = sum_temp[4];
	
	// Assign the sum output
	assign sum = {carry, sum_temp[3:0]};
	
endmodule
