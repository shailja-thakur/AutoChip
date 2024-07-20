module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

// Wire to connect the selected input to the output
wire selected_input;

// 256-to-1 multiplexer with the input vector and select signal
mux256to1 mux (
	.in(in),
	.sel(sel),
	.out(selected_input)
);

// Assign the selected input to the output
assign out = selected_input;

endmodule
module mux256to1 (
	input [255:0] in,
	input [7:0] sel,
	output out
);

// Internal wire to connect the selected input to the output
wire selected_input;

// Assign the selected input based on the select signal
assign selected_input = sel[7] ? in[255] :
					sel[6] ? in[254] :
					sel[5] ? in[253] :
					sel[4] ? in[252] :
					sel[3] ? in[251] :
					sel[2] ? in[250] :
					sel[1] ? in[249] :
					in[248];

// Assign the output with the selected input
assign out = selected_input;

endmodule
