module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // K-map function implementation using minimal number of 2-to-1 multiplexers

    // mux_in[0] corresponds to ab = 00
    assign mux_in[0] = (~c & d) | c;

    // mux_in[1] corresponds to ab = 01
    assign mux_in[1] = 0;

    // mux_in[2] corresponds to ab = 11
    assign mux_in[2] = (c & d);

    // mux_in[3] corresponds to ab = 10
    assign mux_in[3] = (~c & ~d) | c;

endmodule
