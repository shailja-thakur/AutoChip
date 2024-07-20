module top_module (
	input [7:0] in,
	output parity
);

reg parity;
wire [7:0] in_xor;

assign in_xor = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

assign parity = in_xor;

endmodule
