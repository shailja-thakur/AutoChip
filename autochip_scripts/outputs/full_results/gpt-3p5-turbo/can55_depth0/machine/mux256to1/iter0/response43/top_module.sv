module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Declare a wire to hold the selected bit
	wire selected_bit;

	// Implement logic to select bit based on selection vector
	assign selected_bit = in[sel];

	// Assign the output to the selected bit
	assign out = selected_bit;

endmodule
