module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = d;              // ab = 00 -> mux_in[0]
    assign mux_in[1] = 0;              // ab = 01 -> mux_in[1]
    assign mux_in[2] = (~c & d) | c;   // ab = 11 -> mux_in[2]
    assign mux_in[3] = c | d;          // ab = 10 -> mux_in[3]

endmodule
