module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Assign the sum of x and y to sum
	assign sum = x + y;
endmodule
