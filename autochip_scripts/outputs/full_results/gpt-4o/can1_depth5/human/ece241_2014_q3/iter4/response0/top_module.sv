module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implementing the K-map using minimum number of 2-to-1 multiplexers
    assign mux_in[0] = 0;           // ab = 00; f = 0
    assign mux_in[1] = 0;           // ab = 01; f = 0
    assign mux_in[2] = c;           // ab = 11; f = c
    assign mux_in[3] = 1;           // ab = 10; f = 1

endmodule
