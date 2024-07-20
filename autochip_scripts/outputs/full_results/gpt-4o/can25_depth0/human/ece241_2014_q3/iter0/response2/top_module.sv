module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Karnaugh map implementation
    // mux_in[0] corresponds to ab = 00:
    assign mux_in[0] = (~c & d) | (c & ~d) | (c & d); // Simplified to 1

    // mux_in[1] corresponds to ab = 01:
    assign mux_in[1] = 0;

    // mux_in[2] corresponds to ab = 11:
    assign mux_in[2] = (c & d) | (~c & d);

    // mux_in[3] corresponds to ab = 10:
    assign mux_in[3] = (~c & ~d) | (c & d);

endmodule
