module top_module (
	input [7:0] in,
	output [7:0] out
);

	assign out[7:0] = in[0:7];

endmodule
