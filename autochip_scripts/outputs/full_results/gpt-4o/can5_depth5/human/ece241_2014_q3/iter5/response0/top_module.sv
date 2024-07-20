module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define mux inputs based on the Karnaugh map
    assign mux_in[0] = d;             // ab = 00: (c,d) = 00 -> 0, 01 -> 1, 10 -> 1, 11 -> 1
    assign mux_in[1] = 1'b0;          // ab = 01: always 0
    assign mux_in[2] = c | d;         // ab = 11: (c,d) = 00 -> 0, 01 -> 0, 10 -> 0, 11 -> 1
    assign mux_in[3] = c | ~d;        // ab = 10: (c,d) = 00 -> 1, 01 -> 0, 10 -> 1, 11 -> 1

endmodule
