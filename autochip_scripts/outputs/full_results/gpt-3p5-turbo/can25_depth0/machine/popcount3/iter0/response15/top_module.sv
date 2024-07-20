module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Combinational logic to calculate the output
	// The most significant bit of the result is stored in out[1]
	// The least significant bit is stored in out[0]
	assign out[1] = in[2] & in[1];
	assign out[0] = in[1] ^ in[0];
endmodule
