module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);

always @(*) begin
	// Calculate the starting index using the selection vector
	integer start_index;
	start_index = sel * 4;
	
	// Extract the 4-bit block starting from the calculated index
	out = in[start_index +: 4];
end

endmodule
