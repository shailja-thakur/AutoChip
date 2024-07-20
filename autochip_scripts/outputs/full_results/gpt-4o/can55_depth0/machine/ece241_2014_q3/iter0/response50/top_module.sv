module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = c | d; // first bit is OR of c and d
    assign mux_in[1] = 1'b0; // second bit is 0
    assign mux_in[2] = ~d; // third bit is NOT d
    assign mux_in[3] = c & d; // fourth bit is AND of c and d

endmodule
