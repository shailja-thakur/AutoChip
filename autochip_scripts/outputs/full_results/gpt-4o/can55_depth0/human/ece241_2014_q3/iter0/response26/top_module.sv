module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Karnaugh Map implementation for mux_in

    // mux_in[0] corresponds to ab = 00:
    // The conditions for outputting 1 are cd = 10, 11, 01
    // So mux_in[0] = (d & c) | (~c & d) | (c & ~d)
    assign mux_in[0] = (~c & d) | (c & ~d) | (c & d);

    // mux_in[1] corresponds to ab = 01:
    // The conditions for outputting 1 are cd = none
    // So mux_in[1] = 0
    assign mux_in[1] = 1'b0;

    // mux_in[2] corresponds to ab = 11:
    // The conditions for outputting 1 are cd = 11
    assign mux_in[2] = (c & d);

    // mux_in[3] corresponds to ab = 10:
    // The conditions for outputting 1 are cd = 00, 11, 10
    // So mux_in[3] = (~d & ~c) | (c & d) | (~d & c)
    assign mux_in[3] = (~d & ~c) | (c & d) | (~d & c);

endmodule
