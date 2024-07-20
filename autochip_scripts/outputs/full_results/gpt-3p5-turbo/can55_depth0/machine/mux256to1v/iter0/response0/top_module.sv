module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	//Define a wire to store the starting index of the 4-bit block in the input vector
	wire [9:0] start_index;
	
	//Calculate the starting index based on the selection vector
	assign start_index = sel * 4;
	
	//Extract the 4-bit block from the input vector based on the starting index
	assign out = in[start_index +: 4];
	
endmodule
