module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Create 256 1-bit wire connections for the multiplexer inputs
	wire [255:0] mux_inputs;

	// Create a 1-bit wire for the selected input
	wire selected_input;

	// Create a 1-bit output wire
	wire out;

	// Assign the selected input wire based on the value of sel
	assign selected_input = in[sel];

	// Create a 256-to-1 multiplexer using the selected input wire and the 256 input wires
	assign out = mux_inputs[sel];

	// Create connections for the inputs of the multiplexer
	assign mux_inputs = in;

endmodule
