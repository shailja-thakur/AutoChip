module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
wire [7:0] sel_extended;
wire [255:0] sel_vector;
wire [255:0] selected_bit;

assign sel_extended = {sel, 8'b0};
assign sel_vector = {8{sel_extended}};
assign selected_bit = in & sel_vector;

assign out = selected_bit == 256'd0 ? 1'b0 : 1'b1;

endmodule
