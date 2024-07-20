module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

    // out_both: Each bit indicates whether both the corresponding bit and its higher-index neighbour are '1'.
	assign out_both[2] = in[3] & in[2];
	assign out_both[1] = in[2] & in[1];
	assign out_both[0] = in[1] & in[0];

    // out_any: Each bit indicates whether either the corresponding bit or its lower-index neighbour are '1'.
	assign out_any[3] = in[3] | in[2];
	assign out_any[2] = in[2] | in[1];
	assign out_any[1] = in[1] | in[0];

    // out_different: Each bit indicates whether it is different from its higher-index neighbour (with wrapping around).
	assign out_different[3] = in[3] ^ in[0]; // wrapping around
	assign out_different[2] = in[2] ^ in[3];
	assign out_different[1] = in[1] ^ in[2];
	assign out_different[0] = in[0] ^ in[1];

endmodule
