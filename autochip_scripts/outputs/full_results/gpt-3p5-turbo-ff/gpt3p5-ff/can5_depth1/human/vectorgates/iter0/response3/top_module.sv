module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);
	
	// Wire declarations
	wire [2:0] inverse_a;
	wire [2:0] inverse_b;
	
	// Bitwise OR logic
	assign out_or_bitwise = a | b;
	
	// Logical OR logic
	assign out_or_logical = |out_or_bitwise;
	
	// NOT logic
	assign inverse_a = ~a;
	assign inverse_b = ~b;
	assign out_not = {inverse_b, inverse_a};
	
endmodule
