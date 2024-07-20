module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Declare a wire to store the selected bit
	wire selected_bit;

	// Use the selection vector to get the selected bit from the input vector
	assign selected_bit = in[sel];

	// Output the selected bit
	assign out = selected_bit;

endmodule
