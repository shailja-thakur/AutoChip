module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] in_sel;
assign in_sel = in[4*sel +: 4]; // Multiplexing the input bits based on the select line

assign out = in_sel;

endmodule
