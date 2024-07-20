module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Declare variables
	reg [3:0] start_index;
	wire [1023:0] shifted_vec;
	
	// Calculate the starting index based on the selection vector
	always @* begin
		start_index = sel << 2;
	end
	
	// Shift the input vector to align with the starting index
	assign shifted_vec = {in[1023:start_index], in[start_index-1:0]};
	
	// Assign the selected 4-bit block to the output vector
	assign out = shifted_vec[3:0];
	
endmodule
