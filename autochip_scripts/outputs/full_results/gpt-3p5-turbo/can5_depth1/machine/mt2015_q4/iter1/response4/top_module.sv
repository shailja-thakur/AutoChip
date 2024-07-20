module top_module(
	input x,
	input y,
	output reg z);
	
	wire a, b;

	assign a = x & ~y; // Using bitwise AND and bitwise NOT for gate 1
	assign b = ~x & y; // Using bitwise NOT and bitwise AND for gate 2
	assign z = a & b; // Using bitwise AND for gate 3

endmodule
