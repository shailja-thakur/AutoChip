module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] selExtended;

assign selExtended = sel;

assign out = in[selExtended];
endmodule
