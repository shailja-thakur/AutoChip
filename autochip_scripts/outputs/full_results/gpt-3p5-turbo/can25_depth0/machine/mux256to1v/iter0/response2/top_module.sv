module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Calculate the starting index of the 4-bit block
	reg [9:0] startIndex;

	always @(*)
	begin
		startIndex = sel * 4;
	end

	// Extract the 4-bit block from the input vector
	assign out = in[startIndex +: 4];

endmodule
