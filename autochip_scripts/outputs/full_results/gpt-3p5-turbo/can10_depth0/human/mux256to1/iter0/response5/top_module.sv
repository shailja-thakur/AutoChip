module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] selected_input;

assign selected_input = in[sel];

assign out = selected_input[0];

endmodule
