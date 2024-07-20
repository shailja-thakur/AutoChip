module top_module (
	input [2:0] in,
	output [1:0] out
);
	
	assign out[1] = in[2] ^ in[1] ^ in[0]; // XOR of all bits
	assign out[0] = in[2] & in[1] | in[2] & in[0] | in[1] & in[0]; // OR of all possible combinations of 2 bits

endmodule
