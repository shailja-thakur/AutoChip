module top_module (
	input [2:0] in,
	output [1:0] out
);
	assign out[1] = in[2] ^ in[1] ^ in[0];   // Perform XOR gate operation on all bits of the input
	assign out[0] = in[2] & in[1] & in[0];   // Perform AND gate operation on all bits of the input
endmodule
