module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implementing the K-map values using 4-to-1 MUX inputs
    // cd = 00 -> mux_in[0] = 1 if (c=1 and d=0) or (c=1 and d=1) or (c=0 and d=1), otherwise 0
    // cd = 01 -> mux_in[1] = 0
    // cd = 11 -> mux_in[2] = 1 if (c=0 and d=1) or (c=1 and d=0) or (c=1 and d=1), otherwise 0
    // cd = 10 -> mux_in[3] = 1 if (c=1 and d=0) or (c=1 and d=1) or (c=0 and d=1), otherwise 0

    assign mux_in[0] = (c & ~d) | (c & d) | (~c & d);
    assign mux_in[1] = 0;
    assign mux_in[2] = (c & ~d) | (c & d) | (~c & d);
    assign mux_in[3] = (c & ~d) | (c & d) | (~c & d);

endmodule
