module top (
	input [2:0] in,
	output [1:0] out
);

	assign out[1] = in[2] & in[1]; // Adding the most significant bit
	assign out[0] = in[2] ^ in[0]; // Adding the least significant bit

endmodule
