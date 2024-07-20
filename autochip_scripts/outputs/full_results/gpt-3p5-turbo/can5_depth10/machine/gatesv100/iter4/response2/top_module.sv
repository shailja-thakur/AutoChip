module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	assign out_both = in[98:0] & in[97:0];
	assign out_any = {1'b0, in};
	assign out_different = {in[0] ^ in[99], in[99:1]};

endmodule
