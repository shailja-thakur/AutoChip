module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

assign out[24] = ~(a ^ a);
assign out[23] = ~(a ^ b);
assign out[22] = ~(a ^ c);
assign out[21] = ~(a ^ d);
assign out[20] = ~(a ^ e);

assign out[19] = ~(b ^ b);
assign out[18] = ~(b ^ c);
assign out[17] = ~(b ^ d);
assign out[16] = ~(b ^ e);

assign out[15] = ~(c ^ c);
assign out[14] = ~(c ^ d);
assign out[13] = ~(c ^ e);

assign out[12] = ~(d ^ d);
assign out[11] = ~(d ^ e);

assign out[10] = ~(e ^ e);

assign out[9] = ~(b ^ a);
assign out[8] = ~(c ^ a);
assign out[7] = ~(d ^ a);
assign out[6] = ~(e ^ a);

assign out[5] = ~(c ^ b);
assign out[4] = ~(d ^ b);
assign out[3] = ~(e ^ b);

assign out[2] = ~(d ^ c);
assign out[1] = ~(e ^ c);

assign out[0] = ~(e ^ d);

endmodule
