module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // mux_in[0], corresponding to ab=00
    assign mux_in[0] = d | c;

    // mux_in[1], corresponding to ab=01
    assign mux_in[1] = 0;

    // mux_in[2], corresponding to ab=11
    assign mux_in[2] = (c & d) | c;

    // mux_in[3], corresponding to ab=10
    assign mux_in[3] = d | ~c;

endmodule
