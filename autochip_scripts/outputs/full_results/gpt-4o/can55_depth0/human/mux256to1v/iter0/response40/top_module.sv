module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Use the select signal to slice out the desired 4-bit chunk from the input vector
	assign out = in[sel*4 +: 4];

endmodule
