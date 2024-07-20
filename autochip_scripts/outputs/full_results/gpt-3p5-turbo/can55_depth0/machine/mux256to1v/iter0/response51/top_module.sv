module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	parameter BLOCK_SIZE = 4;

	reg [1023:0] in_reg;

	always @(posedge clk) begin
		in_reg <= in;
	end

	always @* begin
		// Calculate the starting index of the 4-bit block in the input vector
		integer start_index;
		start_index = sel * BLOCK_SIZE;
		
		// Extract the 4-bit block from the input vector
		out = in_reg[start_index + 3:start_index];
	end
	
endmodule
