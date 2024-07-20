module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    // Assign the mux_in outputs according to the K-map values
    assign mux_in[0] = c & d;             // ab = 00 -> mux_in[0] = cd
    assign mux_in[1] = 1'b0;              // ab = 01 -> mux_in[1] = 0
    assign mux_in[2] = c | (~c & d);      // ab = 11 -> mux_in[2] = c+d = c | (~c & d)
    assign mux_in[3] = ~c | d;            // ab = 10 -> mux_in[3] = ~c + d

endmodule
