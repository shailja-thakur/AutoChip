module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Here, the combinational logic is implemented
	assign out[1] = in[2] + in[1];
	assign out[0] = in[0] ^ in[1];

endmodule
