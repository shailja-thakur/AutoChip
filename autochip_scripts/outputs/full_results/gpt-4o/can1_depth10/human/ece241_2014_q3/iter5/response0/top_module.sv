module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Filling the Karnaugh map as per the given table:
    // mux_in[0] = F(00) = d
    // mux_in[1] = F(01) = 0
    // mux_in[2] = F(11) = c | d
    // mux_in[3] = F(10) = 1

    assign mux_in[0] = d;         // ab=00, F(00) = d
    assign mux_in[1] = 0;         // ab=01, F(01) = 0
    assign mux_in[2] = c | d;     // ab=11, F(11) = c | d
    assign mux_in[3] = 1;         // ab=10, F(10) = 1

endmodule
