module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign outputs according to the Karnaugh map
    // mux_in[0] corresponds to ab = 00
    // mux_in[1] corresponds to ab = 01
    // mux_in[2] corresponds to ab = 11
    // mux_in[3] corresponds to ab = 10

    assign mux_in[0] = (~c & d) | (c & ~d) | (c & d);
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = (c & d) | (~c & ~d);
    assign mux_in[3] = (~c & ~d) | (~c & d) | (c & d);

endmodule
