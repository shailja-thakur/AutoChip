module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Define internal wires and variables
	wire [3:0] index;
	wire [1023:0] selected_block;
	
	// Calculate the starting index of the selected block
	assign index = sel << 2;
	
	// Extract the selected block from the input vector
	assign selected_block = in[index +: 4];
	
	// Assign the selected block to the output vector
	assign out = selected_block;
endmodule
