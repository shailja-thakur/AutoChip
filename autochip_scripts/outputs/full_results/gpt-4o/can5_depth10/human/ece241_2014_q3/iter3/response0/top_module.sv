module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map

    // ab = 00
    assign mux_in[0] = d;   // When ab = 00: 00 -> 0, 01 -> 1, 11 -> 1, 10 -> 1 => d

    // ab = 01
    assign mux_in[1] = 0;  // All values are 0

    // ab = 11
    assign mux_in[3] = c | d;  // When ab = 11: 00 -> 1, 01 -> 1, 11 -> 1, 10 -> 1 => c | d

    // ab = 10
    assign mux_in[2] = 1;  // When ab = 10: 00 -> 1, 01 -> 0, 11 -> 1, 10 -> 1 => 1

endmodule
