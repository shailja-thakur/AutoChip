module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Declare a wire to select the output bit
	wire [255:0] selected_bit;

	// Use the selection vector to select the corresponding bit from the input vector
	assign selected_bit = in[sel];

	// Assign the output bit to the selected bit
	assign out = selected_bit;

endmodule
