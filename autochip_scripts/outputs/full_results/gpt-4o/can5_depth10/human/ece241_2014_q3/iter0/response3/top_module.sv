module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	assign mux_in[0] = (~c & ~d) | (c & ~d) | (c & d);  // Logic for ab = 00
	assign mux_in[1] = 0;                              // Logic for ab = 01
	assign mux_in[2] = (c & d);                        // Logic for ab = 11
	assign mux_in[3] = (~c & d) | (c & ~d) | (c & d);  // Logic for ab = 10

endmodule
