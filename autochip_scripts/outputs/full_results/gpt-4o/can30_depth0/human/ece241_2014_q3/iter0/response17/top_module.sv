module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = d;           // ab = 00, (cd) = 00 or 10 (both cases output 1)
    assign mux_in[1] = 1'b0;        // ab = 01, (all cases output 0)
    assign mux_in[2] = (c & d);     // ab = 11, (cd) = 11 (output 1), otherwise (00, 01, 10) -> output 0
    assign mux_in[3] = ~c | d;      // ab = 10, (cd) = 00, 10 (output 1), otherwise (01, 11) -> output 0

endmodule
