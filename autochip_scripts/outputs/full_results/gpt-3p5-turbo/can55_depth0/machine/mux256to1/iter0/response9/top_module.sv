module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Wire to store the selected bit
wire selected_bit;

// Instantiate the bit selection module
bit_select_module select_inst (
	.in(in), // Input vector
	.sel(sel), // Selection vector
	.out(selected_bit) // Selected bit
);

// Assign the selected bit to the output
assign out = selected_bit;

endmodule
