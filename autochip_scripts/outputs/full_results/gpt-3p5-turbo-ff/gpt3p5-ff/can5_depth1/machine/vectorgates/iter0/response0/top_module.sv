module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Wire for the bitwise OR output
	wire [2:0] bitwise_or_output;
	
	// Wire for the logical OR output
	wire logical_or_output;
	
	// Wire for the bitwise NOT output
	wire [5:0] bitwise_not_output;
	
	// Assigning the bitwise OR output
	assign bitwise_or_output = a | b;
	
	// Assigning the logical OR output
	assign logical_or_output = a || b;
	
	// Assigning the bitwise NOT output
	assign bitwise_not_output = ~{b, a};
	
	// Assigning the module outputs
	assign out_or_bitwise = bitwise_or_output;
	assign out_or_logical = logical_or_output;
	assign out_not = bitwise_not_output;

endmodule
