module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);
	
	assign out_or_bitwise = a | b; // Bitwise OR operation
	
	assign out_or_logical = (a != 3'b000) || (b != 3'b000); // Logical OR operation
	
	assign out_not = ~{b, a}; // Bitwise NOT operation in reverse order
	
endmodule
