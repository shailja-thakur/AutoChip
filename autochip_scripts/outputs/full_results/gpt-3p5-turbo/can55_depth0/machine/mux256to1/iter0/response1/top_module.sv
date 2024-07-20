module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

  wire [7:0] index = sel;
  wire out = in[index];

endmodule
