module top_module (
	input [2:0] in,
	output [1:0] out
);
	assign out[1] = in[2] & in[1];   // Perform AND gate operation on the 2nd and 1st bits of the input
	assign out[0] = out[1] & in[0];  // Perform AND gate operation on the previous AND output and the 0th bit of the input
endmodule
