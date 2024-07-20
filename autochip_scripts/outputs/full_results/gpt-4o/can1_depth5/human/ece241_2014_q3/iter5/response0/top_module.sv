module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Corrected Karnaugh map interpretation
    assign mux_in[0] = d;           // ab = 00; f = d
    assign mux_in[1] = 0;           // ab = 01; f = 0
    assign mux_in[2] = c | d;       // ab = 11; f = c | d
    assign mux_in[3] = 1;           // ab = 10; f = 1

endmodule
