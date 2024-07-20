module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // According to the K-map, we need to map (c,d) to the corresponding mux_in values:
    // mux_in[0] = 1 when (c,d) = 10, 11, 01
    // mux_in[1] = 0 always
    // mux_in[2] = 1 when (c,d) = 11
    // mux_in[3] = 1 when (c,d) = 00, 10

    assign mux_in[0] = (~c & d) | (c & d) | (c & ~d);
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = c & d;
    assign mux_in[3] = (~c & ~d) | (c & ~d) | (c & d);

endmodule
