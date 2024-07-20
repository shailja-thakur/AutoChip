module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Number of bits required to represent the input
	parameter WIDTH = 256;
	
	// Number of select signals
	parameter SEL_WIDTH = 8;
	
	// Width of the output
	parameter OUT_WIDTH = 1;
	
	// Create a wire to store the selected input
	wire [WIDTH-1:0] selected_input;
	
	// Create the multiplexer
	assign selected_input = in[sel];
	
	// Output the selected input
	assign out = selected_input[0];
endmodule
