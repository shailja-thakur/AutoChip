module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = ~c | d;       // mux_in[0] must be 1 when ab=00, as column 00: 1 at (10, 00) and (11, 00)
    assign mux_in[1] = 1'b0;          // mux_in[1] must be 0 when ab=01: all 0s in column 01
    assign mux_in[2] = c & d;         // mux_in[2] must be d when ab=11: 1 at (11, 11)
    assign mux_in[3] = c | d;         // mux_in[3] must be 1 when ab=10 as 1 at (00, 10), (10, 10)

endmodule
