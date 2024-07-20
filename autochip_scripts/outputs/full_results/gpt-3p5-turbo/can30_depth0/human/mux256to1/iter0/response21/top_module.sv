module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] select_wire;

assign select_wire = in[sel];

assign out = select_wire;
endmodule
