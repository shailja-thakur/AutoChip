module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assigning values to mux_in based on the Karnaugh map
    assign mux_in[0] = (~c & ~d);  // ab = 00, cd = 00 -> 0, cd = 01 -> 1, cd = 11 -> 1, cd = 10 -> 1
    assign mux_in[1] = 0;          // ab = 01, cd = 00 -> 0, cd = 01 -> 0, cd = 11 -> 0, cd = 10 -> 0
    assign mux_in[2] = (c & ~d);   // ab = 11, cd = 00 -> 0, cd = 01 -> 0, cd = 11 -> 1, cd = 10 -> 0
    assign mux_in[3] = (~c | d);   // ab = 10, cd = 00 -> 1, cd = 01 -> 0, cd = 11 -> 1, cd = 10 -> 1

endmodule
