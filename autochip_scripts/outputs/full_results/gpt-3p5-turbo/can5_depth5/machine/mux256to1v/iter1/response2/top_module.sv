module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [3:0] out_reg;

	always @* begin
		// Calculate the starting index of the 4-bit block in the input vector
		integer start_index;
        reg [3:0] temp;

		always @* begin
			start_index = sel * 4;
		end

		// Extract the 4-bit block from the input vector
		always @* begin
			temp = in[start_index +: 4];
		end
	
	end
	
	// Assign the output
	assign out = temp;
	
endmodule
