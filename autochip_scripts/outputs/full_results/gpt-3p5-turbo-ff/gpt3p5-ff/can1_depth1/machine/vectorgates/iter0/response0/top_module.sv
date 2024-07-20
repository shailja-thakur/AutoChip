module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Wire declaration
	wire [2:0] bitwise_or;
	wire logical_or;
	wire [5:0] bitwise_not;
	
	// Bitwise OR operation
	assign bitwise_or = a | b;
	
	// Logical OR operation
	assign logical_or = (a != 0) || (b != 0);
	
	// Bitwise NOT operation
	assign bitwise_not = ~{a, b};
	
	// Output assignments
	assign out_or_bitwise = bitwise_or;
	assign out_or_logical = logical_or;
	assign out_not = bitwise_not;

endmodule
