module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Create wires for selecting the appropriate bits from the input
	wire [255:0] selected_input;

	// Generate the selected_input wire based on the value of sel
	assign selected_input = in[sel*256 +: 256];

	// Create the 4-to-1 mux for each bit of the output
	// and assign the selected input to the appropriate output bit
	assign out[0] = selected_input[3:0];
	assign out[1] = selected_input[7:4];
	assign out[2] = selected_input[11:8];
	assign out[3] = selected_input[15:12];

endmodule
