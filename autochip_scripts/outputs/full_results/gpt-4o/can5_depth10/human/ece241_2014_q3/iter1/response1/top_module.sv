module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    // Correct assignment of values to mux_in based on the Karnaugh map
    assign mux_in[0] = d;         // ab = 00 -> mux_in[0] = d
    assign mux_in[1] = 0;         // ab = 01 -> mux_in[1] = 0
    assign mux_in[2] = c | d;     // ab = 11 -> mux_in[2] = c | d
    assign mux_in[3] = 1;         // ab = 10 -> mux_in[3] = 1

endmodule
