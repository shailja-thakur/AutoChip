module top_module (
	input [31:0] in,
	output [31:0] out
);
	assign {out[31:24], out[23:16], out[15:8], out[7:0]} = in;
endmodule
