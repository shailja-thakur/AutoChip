module top_module (
	input c,
	input d,
	output wire [3:0] mux_in
);

	// Implementing the Karnaugh Map using multiplexers
	// Creating a 2-to-1 multiplexer for each output bit of mux_in

	// First output bit mux_in[0]
	// Mux input selection based on c, d
	// c d = 00 -> mux_in[0] = 1'b1
	// c d = 01 -> mux_in[0] = 1'b0
	// c d = 11 -> mux_in[0] = 1'b1
	// c d = 10 -> mux_in[0] = 1'b1
	assign mux_in[0] = (~c & d) | (c & ~d);

	// Second output bit mux_in[1]
	// Mux input selection based on c, d
	// c d = 00 -> mux_in[1] = 1'b0
	// c d = 01 -> mux_in[1] = 1'b1
	// c d = 11 -> mux_in[1] = 1'b0
	// c d = 10 -> mux_in[1] = 1'b0
	assign mux_in[1] = (~c & ~d) | (c & d);

	// Third output bit mux_in[2]
	// Mux input selection based on c, d
	// c d = 00 -> mux_in[2] = 1'b0
	// c d = 01 -> mux_in[2] = 1'b1
	// c d = 11 -> mux_in[2] = 1'b0
	// c d = 10 -> mux_in[2] = 1'b0
	assign mux_in[2] = (~c & ~d);

	// Fourth output bit mux_in[3]
	// Mux input selection based on c, d
	// c d = 00 -> mux_in[3] = 1'b1
	// c d = 01 -> mux_in[3] = 1'b0
	// c d = 11 -> mux_in[3] = 1'b1
	// c d = 10 -> mux_in[3] = 1'b1
	assign mux_in[3] = (~c & d) | (c & ~d);
endmodule
