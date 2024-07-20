module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Declare wire to store calculated index
	wire [9:0] index;
	
	// Calculate index using selection vector
	assign index = sel * 4;
	
	// Assign output vector with selected block from input vector
	assign out = in[index +: 4];

endmodule
