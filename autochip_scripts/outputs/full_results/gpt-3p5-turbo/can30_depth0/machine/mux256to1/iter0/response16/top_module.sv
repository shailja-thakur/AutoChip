module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Wire to hold the selected bit from the input vector
	wire selected_bit;
	
	// Assign the selected bit from the input vector
	assign selected_bit = in[sel];
	
	// Assign the selected bit to the output
	assign out = selected_bit;

endmodule
