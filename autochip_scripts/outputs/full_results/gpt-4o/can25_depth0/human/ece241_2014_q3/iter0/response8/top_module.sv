module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Each output corresponds to a 4-to-1 multiplexer input, based on the K-map.

    // mux_in[0] corresponds to ab = 00:
    // It covers cd = 00, 01, 11, 10 with values 0, 1, 1, 1 respectively. 
    assign mux_in[0] = (~c & d) | (c & d) | (c & ~d);

    // mux_in[1] corresponds to ab = 01:
    // It covers cd = 00, 01, 11, 10 with values 0, 0, 0, 0 respectively.
    assign mux_in[1] = 0;

    // mux_in[2] corresponds to ab = 11:
    // It covers cd = 00, 01, 11, 10 with values 0, 0, 1, 0 respectively.
    assign mux_in[2] = c & d;

    // mux_in[3] corresponds to ab = 10:
    // It covers cd = 00, 01, 11, 10 with values 1, 0, 1, 1 respectively.
    assign mux_in[3] = (~c & ~d) | (c & d) | (c & ~d);

endmodule
