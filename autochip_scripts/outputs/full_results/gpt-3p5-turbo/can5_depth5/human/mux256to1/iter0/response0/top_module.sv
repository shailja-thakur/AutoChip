module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Create an array to store the selected input bits
	wire [7:0] selected_bits;

	// Select the appropriate bits based on the value of sel
	assign selected_bits = in[sel];

	// Perform bitwise OR operation on all selected bits
	assign out = |selected_bits;
endmodule
