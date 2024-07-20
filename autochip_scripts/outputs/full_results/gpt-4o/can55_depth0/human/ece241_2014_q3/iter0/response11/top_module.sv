module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	assign mux_in[0] = d;          // cd = 00, f = 1 when a=1, b=0
	assign mux_in[1] = 0;           // cd = 01, f is always 0
	assign mux_in[2] = c | d;      // cd = 11, f is 1 when cd=11 or cd=10 => c | d
	assign mux_in[3] = 1;           // cd = 10, f is always 1

endmodule
