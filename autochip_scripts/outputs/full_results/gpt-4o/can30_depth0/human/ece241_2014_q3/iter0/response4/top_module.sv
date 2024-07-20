module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
    // Assign mux_in based on the given Karnaugh map
    // mux_in[0] corresponds to ab = 00
    // mux_in[1] corresponds to ab = 01
    // mux_in[2] corresponds to ab = 11
    // mux_in[3] corresponds to ab = 10

    assign mux_in[0] = (~c & d) | (c & ~d);              // 1 if cd = 01, or cd = 11, or 10
    assign mux_in[1] = 0;                                // Always 0
    assign mux_in[2] = (c & d) | (~c & ~d);              // 1 if cd = 11
    assign mux_in[3] = (c & ~d) | (~c & d);              // 1 if cd = 10, or cd = 00

endmodule
