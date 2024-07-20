module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	assign mux_in[0] = c | d;   // The first bit is the logical OR of c and d
	assign mux_in[1] = 0;       // The second bit is 0
	assign mux_in[2] = ~d;      // The third bit is the logical NOT of d
	assign mux_in[3] = c & d;   // The fourth bit is the logical AND of c and d

endmodule
