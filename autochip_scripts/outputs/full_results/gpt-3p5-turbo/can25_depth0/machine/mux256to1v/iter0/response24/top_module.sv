module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Calculate the starting index based on the selection vector
	reg [9:0] start_index;
	always @(*)
	begin
		if (sel >= 8)
			start_index = 1024;
		else
			start_index = sel * 128;
	end
	
	// Extract the 4-bit block from the input vector based on the starting index
	reg [3:0] block;
	always @(*)
	begin
		block = in[start_index +: 4];
	end
	
	// Assign the block to the output vector
	assign out = block;
	
endmodule
