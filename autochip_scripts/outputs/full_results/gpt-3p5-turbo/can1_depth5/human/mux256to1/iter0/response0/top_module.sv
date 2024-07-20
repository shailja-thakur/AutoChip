module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] out_wire;

assign out_wire = sel < 256 ? in[sel] : 1'b0;
assign out = out_wire;

endmodule
