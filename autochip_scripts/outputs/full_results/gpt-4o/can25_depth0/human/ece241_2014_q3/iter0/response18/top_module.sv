module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // According to the K-map, we have the following values for mux_in:

    // mux_in[0] corresponds to ab = 00
    assign mux_in[0] = (~c & d) | (c & ~d) | c; // 1 when (c,d) = 10, 01 and 11

    // mux_in[1] corresponds to ab = 01
    assign mux_in[1] = 0; // 0 in K-map

    // mux_in[2] corresponds to ab = 11
    assign mux_in[2] = (c & d) | (~c & ~d); // 1 when (c,d) = 11 and 00

    // mux_in[3] corresponds to ab = 10
    assign mux_in[3] = (~c & d) | c; // 1 when (c,d) = 00, 01 and 10

endmodule
