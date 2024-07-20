module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	
	wire [7:0] index; // 8-bit wire to hold the index of the selected bit

	assign index = sel; // assign the selection vector to the index wire

	assign out = in[index]; // assign the selected bit from the input vector to the output

endmodule
