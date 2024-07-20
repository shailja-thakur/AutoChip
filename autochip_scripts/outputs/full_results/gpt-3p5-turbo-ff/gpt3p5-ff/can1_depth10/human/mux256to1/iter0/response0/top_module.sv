module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [(2 ** 8) - 1:0] sel_extended; // Define a wire for extending the sel input

assign sel_extended = {8{sel}}; // Extend sel input to match the size of in

assign out = in[sel_extended]; // Assign the selected bits from in to out based on sel_extended

endmodule
