module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Assign the truth table values to the outputs of the 4-to-1 multiplexer
	assign mux_in[0] = (~c & d) | (c & ~d) | c; // F = 1001 (binary) -> (1 when cd=00, 1 when cd=10, 1 when cd=11)
	assign mux_in[1] = 1'b0;                    // All 0's in the K-map column for ab=01
	assign mux_in[2] = (c & d) | (c & ~d);      // F = 1011 (binary) -> (1 when cd=00, 1 when cd=01, 1 when cd=10, 1 when cd=11)
	assign mux_in[3] = (~c & ~d) | (c & d);     // F = 1001 (binary) -> (0 when cd=01)

endmodule
