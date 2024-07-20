module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Wire to hold the selected bit
	wire selected_bit;

	// Select the bit from the input vector based on the selection vector
	assign selected_bit = in[sel];

	// Assign the selected bit as the output
	assign out = selected_bit;

endmodule
