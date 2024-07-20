module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Calculate the starting index of the 4-bit block
	// based on the selection vector (sel)
	reg [9:0] index;
	always @(sel) begin
		index = sel << 2;
	end
	
	// Extract the 4-bit block from the input vector (in)
	// starting from the calculated index
	always @(in, index) begin
		out = in[index +: 4];
	end
endmodule
