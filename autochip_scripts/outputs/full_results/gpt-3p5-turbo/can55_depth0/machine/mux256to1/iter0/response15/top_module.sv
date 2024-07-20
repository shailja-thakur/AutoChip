module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	
	// create a wire to store the selected bit
	wire selected_bit;
	
	// use the sel vector to select the corresponding bit from the input vector
	assign selected_bit = in[sel];
	
	// assign the selected bit to the output
	assign out = selected_bit;
	
endmodule
