module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// wire to select the output bit from the input vector
	wire selected_bit;
	
	// assign the selected bit from the input vector based on the selection vector
	assign selected_bit = in[sel];
	
	// assign the output as the selected bit
	assign out = selected_bit;

endmodule
