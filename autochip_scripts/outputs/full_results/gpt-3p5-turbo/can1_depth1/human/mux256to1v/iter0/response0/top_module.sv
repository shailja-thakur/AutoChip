module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Define an internal wire to store the selected 4-bit input
	wire [3:0] selected_input;

	// Assign the selected input based on the sel input
	assign selected_input = in[sel*4 +: 4];

	// Assign the output as the selected input
	assign out = selected_input;

endmodule
