module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	
	wire [7:0] sel_extended;
	assign sel_extended = {sel, 0};
	assign out = in[sel_extended];

endmodule
