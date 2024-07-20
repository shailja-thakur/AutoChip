module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	assign mux_in[0] = c | d;   // Assigning the logical OR of c and d to the first bit of mux_in
	assign mux_in[1] = 0;       // Assigning 0 to the second bit of mux_in
	assign mux_in[2] = ~d;      // Assigning the logical NOT of d to the third bit of mux_in
	assign mux_in[3] = c & d;   // Assigning the logical AND of c and d to the fourth bit of mux_in

endmodule
