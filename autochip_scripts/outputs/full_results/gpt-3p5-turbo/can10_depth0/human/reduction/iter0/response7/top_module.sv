module top_module (
	input [7:0] in,
	output parity
);

wire [7:0] xor;
wire [6:0] sum;

assign xor = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

assign sum[0] = in[0] ^ in[1];
assign sum[1] = sum[0] ^ in[2];
assign sum[2] = sum[1] ^ in[3];
assign sum[3] = sum[2] ^ in[4];
assign sum[4] = sum[3] ^ in[5];
assign sum[5] = sum[4] ^ in[6];
assign sum[6] = sum[5] ^ in[7];

assign parity = xor[0] ^ sum[0] ^ sum[1] ^ sum[2] ^ sum[3] ^ sum[4] ^ sum[5] ^ sum[6];

endmodule
