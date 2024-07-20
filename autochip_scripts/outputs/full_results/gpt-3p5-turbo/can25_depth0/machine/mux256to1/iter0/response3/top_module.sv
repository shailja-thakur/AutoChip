module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Create a wire to hold the selected bit
	wire selected_bit;

	// Assign the selected bit using the selection vector
	assign selected_bit = in[sel];

	// Assign the output using the selected bit
	assign out = selected_bit;

endmodule
