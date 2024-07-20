module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    // Define mux inputs based on the Karnaugh map
    // ab = 00 -> 0, 01 -> 0, 11 -> 0, 10 -> 1
    assign mux_in[0] = d & ~c;  // 1 for (c,d) = 00, 01, 11, 10 (Labelling issues)
    // ab = 01 -> 1, 01 -> 0, 11 -> 0, 10 -> 0
    assign mux_in[1] = ~c & d; // 1 for (c,d) = 00, 01, 11, 10
    // ab = 11 -> 1, 01 -> 0, 01 -> 1, 10 -> 1
    assign mux_in[2] = c & d | c & ~d;      // 1 for (c,d) = 00, 01, 11, 10
    // ab = 10 -> 1, 01 -> 0, 01 -> 0, 10 -> 1
    assign mux_in[3] =  c | d;  // always 1

endmodule
