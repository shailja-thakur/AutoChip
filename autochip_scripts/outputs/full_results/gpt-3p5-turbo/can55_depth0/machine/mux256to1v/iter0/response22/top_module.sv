module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

    wire [9:0] start_index;  // Calculate starting index
    assign start_index = sel << 4;
    
    wire [1023:0] selected_block;  // Extract selected block from input vector
    assign selected_block = in[start_index +: 16];
    
    assign out = selected_block[3:0];  // Assign selected block to output vector

endmodule
