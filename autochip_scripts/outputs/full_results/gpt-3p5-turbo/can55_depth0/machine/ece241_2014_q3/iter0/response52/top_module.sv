module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	assign mux_in[0] = c | d; // first bit of mux_in is assigned to the logical OR of c and d
	assign mux_in[1] = 0; // second bit of mux_in is assigned to 0
	assign mux_in[2] = ~d; // third bit of mux_in is assigned to the logical NOT of d
	assign mux_in[3] = c & d; // fourth bit of mux_in is assigned to the logical AND of c and d

endmodule
