module top_module (
	input [7:0] in,
	output parity
);

//wire to store the XOR result
wire xor_result;

//xor gate to compute the parity bit
assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

//assign the parity bit to the output
assign parity = xor_result;

endmodule
