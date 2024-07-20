module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Declare internal wires
	wire [255:0] selected_input;

	// Assign selected input using sel
	assign selected_input = (sel >= 0 && sel <= 255) ? in[sel] : 0;

	// Assign output based on selected input
	assign out = selected_input;

endmodule
