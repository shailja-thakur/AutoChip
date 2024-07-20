module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    assign mux_in[0] = d;        // ab = 00, K-map value = 1 when cd = 10, 11, 00, 00 
    assign mux_in[1] = 0;        // ab = 01, K-map value is always 0
    assign mux_in[2] = ~c & ~d;  // ab = 11, K-map value = 1 when cd = 11 
    assign mux_in[3] = c | ~d;   // ab = 10, K-map value = 1 when cd = 00, 10, 11

endmodule
