module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// internal wires
	wire [255:0] selected_bit;

	// wire between input and selected_bit
	assign selected_bit = in[sel];

	// output assignment
	assign out = selected_bit[0];

endmodule
