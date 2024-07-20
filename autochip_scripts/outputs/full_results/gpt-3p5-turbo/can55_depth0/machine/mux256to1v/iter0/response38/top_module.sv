module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate starting index of the 4-bit block
	reg [9:0] start_idx;
	always @* begin
		start_idx = sel * 4;
	end
	
	// Extract the 4-bit block from the input vector
	assign out = in[start_idx +: 4];
	
endmodule
