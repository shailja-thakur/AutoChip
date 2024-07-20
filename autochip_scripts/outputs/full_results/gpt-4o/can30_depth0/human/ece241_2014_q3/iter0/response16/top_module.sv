module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = (~c & d) | (c & ~d) | (c & d);  // 00: mux_in[0] = d + c + cd = 1
    assign mux_in[1] = 0;                             // 01: mux_in[1] = 0
    assign mux_in[2] = c | (~c & d);                  // 11: mux_in[2] = c + (cd)
    assign mux_in[3] = (~c & d) | (c & ~d) | (c & d); // 10: mux_in[3] = d + c + cd = 1

endmodule
