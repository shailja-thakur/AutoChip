module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implementing the Karnaugh map
    // mux_in[0] represents ab = 00
    // mux_in[1] represents ab = 01
    // mux_in[2] represents ab = 11
    // mux_in[3] represents ab = 10

    assign mux_in[0] = ~c & d | c & ~d;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = ~d;
    assign mux_in[3] = ~c | d;

endmodule
