module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// logical OR of inputs c and d
	assign mux_in[0] = c | d;

	// second bit of mux_in is assigned 0
	assign mux_in[1] = 0;

	// logical NOT of input d
	assign mux_in[2] = ~d;

	// logical AND of inputs c and d
	assign mux_in[3] = c & d;

endmodule
