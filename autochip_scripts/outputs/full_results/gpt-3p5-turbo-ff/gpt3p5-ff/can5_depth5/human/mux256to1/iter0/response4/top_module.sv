module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] sel_scaled;
wire [255:0] in_scaled;

assign sel_scaled = sel>>3;
assign in_scaled = in << sel;

assign out = in_scaled[7:0];

endmodule
