module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// The given K-map implementation can be translated to:
	// mux_in[0] = c'd
	// mux_in[1] = 0
	// mux_in[2] = cd + c'd
	// mux_in[3] = 1

	// Assigning the outputs based on the mappings
	assign mux_in[0] = ~c & d;             // 00
	assign mux_in[1] = 0;                  // 01
	assign mux_in[2] = (c & d) | (~c & d); // 11
	assign mux_in[3] = 1;                  // 10

endmodule
