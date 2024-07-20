module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = d;                 // ab = 00: cd = 00 | 01 | 11 | 10 -> 0 | 1 | 1 | 1 -> d
    assign mux_in[1] = 0;                 // ab = 01: cd = 00 | 01 | 11 | 10 -> 0 | 0 | 0 | 0 -> 0
    assign mux_in[2] = (~d & c) | d;      // ab = 11: cd = 00 | 01 | 11 | 10 -> 0 | 0 | 1 | 0 -> (~d & c) | d
    assign mux_in[3] = c;                 // ab = 10: cd = 00 | 01 | 11 | 10 -> 1 | 0 | 1 | 1 -> c

endmodule
