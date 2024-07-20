module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Define a wire to store the selected bit
	wire selected_bit;

	// Use the selection vector to select the bit from the input vector
	assign selected_bit = in[sel];

	// Assign the selected bit to the output
	assign out = selected_bit;

endmodule
