module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] sel_expanded;
assign sel_expanded = sel << 8'h1;

assign out = sel_expanded & in;

endmodule
