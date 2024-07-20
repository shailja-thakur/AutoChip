module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Wire declarations
	wire [2:0] bitwise_or;
	wire logical_or;
	wire [5:0] bitwise_not_a;
	wire [5:0] bitwise_not_b;

	// Bitwise OR operation
	assign bitwise_or = a | b;
	
	// Logical OR operation
	assign logical_or = (a != 0) || (b != 0);
	
	// Bitwise NOT operation on input a
	assign bitwise_not_a = ~a;
	
	// Bitwise NOT operation on input b
	assign bitwise_not_b = ~b;
	
	// Reverse the order of bitwise_not_a and bitwise_not_b to get out_not
	assign out_not = {bitwise_not_b, bitwise_not_a};
	
	// Assign the outputs to the designated output ports
	assign out_or_bitwise = bitwise_or;
	assign out_or_logical = logical_or;

endmodule
