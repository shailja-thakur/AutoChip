module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] index;
wire  out;

assign index = sel;
assign out = in[index];

endmodule
