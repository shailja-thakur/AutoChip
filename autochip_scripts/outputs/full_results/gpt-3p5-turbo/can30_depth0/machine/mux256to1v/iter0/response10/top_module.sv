module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// parameter for the size of the input vector
	parameter VECTOR_SIZE = 1024;

	// parameter for the size of each block
	parameter BLOCK_SIZE = 4;

	// calculate the starting index of the selected block
	reg [11:0] start_index;
	always @(*)
	begin
		start_index = sel * BLOCK_SIZE;
	end

	// extract the selected block from the input vector
	wire [BLOCK_SIZE-1:0] selected_block;
	assign selected_block = in[start_index +: BLOCK_SIZE];

	// assign the selected block to the output vector
	assign out = selected_block;

endmodule
