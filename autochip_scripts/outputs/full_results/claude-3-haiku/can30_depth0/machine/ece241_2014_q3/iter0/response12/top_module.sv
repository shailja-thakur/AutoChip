module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // The first bit of mux_in is assigned to the logical OR of the two inputs, c and d
    assign mux_in[0] = c | d;

    // The second bit of mux_in is assigned to 0
    assign mux_in[1] = 1'b0;

    // The third bit of mux_in is assigned to the logical NOT of the input d
    assign mux_in[2] = ~d;

    // The fourth bit of mux_in is assigned to the logical AND of the two inputs, c and d
    assign mux_in[3] = c & d;

endmodule
