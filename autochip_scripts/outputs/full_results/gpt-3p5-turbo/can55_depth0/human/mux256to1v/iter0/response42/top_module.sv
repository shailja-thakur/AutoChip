module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Declare wires to store intermediate values
	wire [7:0] selected_bits;

	// Select the appropriate bits based on the sel input
	assign selected_bits = in[sel*4 +: 4];

	// Concatenate the selected bits to form the output
	assign out = {selected_bits[3], selected_bits[2], selected_bits[1], selected_bits[0]};
endmodule
