module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] address;
assign address = sel;

wire [255:0] selected_bit;
assign selected_bit = in[address];

assign out = selected_bit;

endmodule
