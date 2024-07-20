module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	/* Declare the wires and variables */
	wire [3:0] selected_block;
	wire [9:0] starting_index;

	/* Calculate the starting index of the selected block */
	assign starting_index = sel * 4;

	/* Extract the selected block from the input vector */
	assign selected_block = in[starting_index + 3 : starting_index];

	/* Assign the selected block to the output vector */
	assign out = selected_block;

endmodule
