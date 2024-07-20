module top_module(
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
// Calculate the starting index based on the selection vector (sel)
reg [9:0] index = sel << 6; 

// Extract the 4-bit block from the input vector (in) starting from the calculated index
assign out = in[index +: 4];

endmodule
