module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implement logic for each mux_in output based on the Karnaugh map
    // mux_in[0] (ab = 00) = c'd + cd' = d
    assign mux_in[0] = d;

    // mux_in[1] (ab = 01) = 0
    assign mux_in[1] = 0;

    // mux_in[2] (ab = 11) = c
    assign mux_in[2] = c;

    // mux_in[3] (ab = 10) = c + d = c | d
    assign mux_in[3] = c | d;

endmodule
