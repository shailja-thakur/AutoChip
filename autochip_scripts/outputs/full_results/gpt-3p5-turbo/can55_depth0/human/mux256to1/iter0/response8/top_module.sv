module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] sel_extended;
assign sel_extended = sel;

wire [31:0] in_extended;
assign in_extended = in;

assign out = in_extended[sel_extended];

endmodule
