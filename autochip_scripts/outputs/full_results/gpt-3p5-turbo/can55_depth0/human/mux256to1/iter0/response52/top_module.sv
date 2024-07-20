module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Create a 1-bit wire to store the selected input
	wire selected_input;
	
	// Use concatenation to select the appropriate bits from 'in' based on 'sel'
	assign selected_input = in[sel];
	
	// Create the 1-bit wide, 256-to-1 multiplexer
	assign out = selected_input;
endmodule
