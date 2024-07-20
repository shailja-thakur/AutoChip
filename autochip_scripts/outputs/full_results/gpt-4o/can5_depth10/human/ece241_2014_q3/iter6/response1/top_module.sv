module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Based on the Karnaugh map, the outputs are calculated as follows:

    // ab = 00
    assign mux_in[0] = d;  // When ab = 00: 00 -> 0, 01 -> 1, 11 -> 1, 10 -> 1

    // ab = 01
    assign mux_in[1] = c & ~d;  // When ab = 01: 00 -> 0, 01 -> 0, 11 -> 0, 10 -> 1

    // ab = 11
    assign mux_in[3] = c | ~d;  // When ab = 11: 00 -> 0, 01 -> 0, 11 -> 1, 10 -> 1

    // ab = 10
    assign mux_in[2] = d | c;  // When ab = 10: 00 -> 1, 01 -> 0, 11 -> 1, 10 -> 1

endmodule
