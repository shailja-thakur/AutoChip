module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Combinational Logic to calculate the sum
	assign out[1] = in[2] ^ in[1] ^ in[0]; // Bitwise XOR between inputs
	assign out[0] = in[1] & in[0]; // Bitwise AND between inputs
endmodule
