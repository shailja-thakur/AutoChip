module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Calculate the starting index of the 4-bit block
	wire [9:0] index = {sel, 2'b00}; // Multiply sel by 4 by shifting it by 2 bits to the left

	// Extract the 4-bit block and assign it to the output
	assign out = in[index +: 4];
endmodule
