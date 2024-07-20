module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a temporary wire to store the selected input
	wire [255:0] selected_input;

	// Determine the index of the selected input
	assign selected_input = in[sel * 256 +: 256];

	// Assign the output to the selected input
	assign out = selected_input[3:0];
endmodule
