module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

wire w_a, w_b, w_c, w_d, w_e;

assign w_a = ~a;
assign w_b = ~b;
assign w_c = ~c;
assign w_d = ~d;
assign w_e = ~e;

assign out[24] = w_a ^ a;
assign out[23] = w_a ^ b;
assign out[22] = w_a ^ c;
assign out[21] = w_a ^ d;
assign out[20] = w_a ^ e;
assign out[19] = w_b ^ a;
assign out[18] = w_b ^ b;
assign out[17] = w_b ^ c;
assign out[16] = w_b ^ d;
assign out[15] = w_b ^ e;
assign out[14] = w_c ^ a;
assign out[13] = w_c ^ b;
assign out[12] = w_c ^ c;
assign out[11] = w_c ^ d;
assign out[10] = w_c ^ e;
assign out[9] = w_d ^ a;
assign out[8] = w_d ^ b;
assign out[7] = w_d ^ c;
assign out[6] = w_d ^ d;
assign out[5] = w_d ^ e;
assign out[4] = w_e ^ a;
assign out[3] = w_e ^ b;
assign out[2] = w_e ^ c;
assign out[1] = w_e ^ d;
assign out[0] = w_e ^ e;

endmodule
