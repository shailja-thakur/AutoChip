module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Create an internal wire to store the selected input
wire [255:0] selected_input;

// Create a decoder to select the appropriate input
decoder dec (
	.input(sel),
	.enable(1'b1),
	.output(selected_input)
);

// Assign the output to the selected input
assign out = selected_input;

endmodule
