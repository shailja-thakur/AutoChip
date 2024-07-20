module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Create internal wire to hold the selected input bits
wire [255:0] selected_input;

// Select the corresponding bits from the input vector based on the value of sel
assign selected_input = in[sel*256 +: 256];

// Create a 4-to-1 multiplexer using the selected_input as inputs
// Use sel[1:0] as the select lines for the multiplexer
mux4to1 mux1(
	.in0(selected_input[3:0]),
	.in1(selected_input[7:4]),
	.in2(selected_input[11:8]),
	.in3(selected_input[15:12]),
	.sel(sel[1:0]),
	.out(out)
);

endmodule
