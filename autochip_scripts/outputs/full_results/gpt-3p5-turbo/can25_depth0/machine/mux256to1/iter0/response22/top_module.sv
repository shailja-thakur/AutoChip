module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Wire for connecting the selected bit to the output
	wire selected_bit;
	
	// Assign the selected bit based on the selection vector
	assign selected_bit = in[sel];
	
	// Assign the output to the selected bit
	assign out = selected_bit;

endmodule
