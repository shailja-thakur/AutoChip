module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	wire [255:0] selected_bits;
	assign selected_bits = in & (1 << sel);

	assign out = selected_bits[sel];
endmodule
