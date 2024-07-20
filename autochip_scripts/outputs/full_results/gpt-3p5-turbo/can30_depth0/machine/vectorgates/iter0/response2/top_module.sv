module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Perform bitwise OR operation on inputs a and b
	assign out_or_bitwise = a | b;
	
	// Perform logical OR operation on inputs a and b
	assign out_or_logical = (a != 0) || (b != 0);
	
	// Perform bitwise NOT operation on inputs a and b in reverse order
	assign out_not = ~{b, a};
	
endmodule
