module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // According to the Karnaugh map:
    // mux_in[0] corresponds to ab = 00
    // mux_in[1] corresponds to ab = 01
    // mux_in[2] corresponds to ab = 11
    // mux_in[3] corresponds to ab = 10

    // Connect inputs based on the Karnaugh map

    // mux_in[0] = ~(c & d)
    assign mux_in[0] = ~(c & d);
    // mux_in[1] = 0, always zero
    assign mux_in[1] = 1'b0;
    // mux_in[2] = c | d
    assign mux_in[2] = c | d;
    // mux_in[3] = c & ~d
    assign mux_in[3] = c & ~d;

endmodule
