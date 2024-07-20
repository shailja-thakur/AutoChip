module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Create a wire to store the selected input
	wire [1023:0] selected_input;

	// Divide the input into 256 4-bit segments
	genvar i;
	generate
		for (i = 0; i < 256; i = i + 1) begin : input_gen
			// Select the correct 4-bit segment based on sel
			assign selected_input[i*4 +: 4] = in[i*4 + sel*4 +: 4];
		end
	endgenerate

	// Create the 256-to-1 multiplexer
	assign out = selected_input[(sel*4)+:4];
	
endmodule
