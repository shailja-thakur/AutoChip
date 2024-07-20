module top_module (
	input [7:0] in,
	output parity
);

wire [7:0] xor_out;
wire       xor_result;

xor_gate u1(xor_out[0], in[0], in[1]);
xor_gate u2(xor_out[1], in[2], in[3]);
xor_gate u3(xor_out[2], in[4], in[5]);
xor_gate u4(xor_out[3], in[6], in[7]);

xor_gate u5(xor_out[4], xor_out[0], xor_out[1]);
xor_gate u6(xor_out[5], xor_out[2], xor_out[3]);

xor_gate u7(xor_out[6], xor_out[4], xor_out[5]);

xor_gate u8(xor_out[7], xor_out[6]);

assign xor_result = xor_out[7];

assign parity = xor_result;

endmodule
