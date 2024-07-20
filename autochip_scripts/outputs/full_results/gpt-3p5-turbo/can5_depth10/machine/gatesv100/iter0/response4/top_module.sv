module top_module (
	input [99:0] in,
	output [99:1] out_any,
	output [99:0] out_both,
	output [99:0] out_different
);
	assign out_both = in & {0,in};
	assign out_any = in | {1'b0, in};
	assign out_different = {in[0] ^ in[99], in} & ~{0,in};
endmodule
