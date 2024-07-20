module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] sel_extended;
assign sel_extended = {8{sel}};

wire [7:0] mux_out;
assign mux_out = in[8*sel_extended +: 8];

assign out = mux_out;

endmodule
