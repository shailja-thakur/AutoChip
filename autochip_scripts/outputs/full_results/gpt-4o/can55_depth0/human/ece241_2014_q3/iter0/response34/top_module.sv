module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign the values of mux_in based on the given Karnaugh map
    // ab = 00, mux_in[0] = (c'd')
    // ab = 01, mux_in[1] = (c'd)
    // ab = 11, mux_in[2] = (cd)
    // ab = 10, mux_in[3] = (cd')
    
    assign mux_in[0] = (c & ~d) | (c & d) | (~c & d);
    assign mux_in[1] = 0;
    assign mux_in[2] = (c & d);
    assign mux_in[3] = (c & ~d) | (~c & ~d) | (c & d);

endmodule
