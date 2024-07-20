module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Define intermediate signals
	wire [1023:0] selected_block;
	wire [10:0] start_index;
	
	// Calculate the starting index of the selected block
	assign start_index = sel * 4;
	
	// Extract the selected block from the input vector
	assign selected_block = in[start_index + 3 : start_index];
	
	// Assign the selected block to the output vector
	assign out = selected_block;
	
endmodule
