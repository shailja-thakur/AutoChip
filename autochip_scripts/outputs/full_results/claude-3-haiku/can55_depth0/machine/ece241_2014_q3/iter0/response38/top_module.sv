module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign the first bit of mux_in to the logical OR of the two inputs, c and d
    assign mux_in[0] = c | d;

    // Assign the second bit of mux_in to 0
    assign mux_in[1] = 1'b0;

    // Assign the third bit of mux_in to the logical NOT of the input d
    assign mux_in[2] = ~d;

    // Assign the fourth bit of mux_in to the logical AND of the two inputs, c and d
    assign mux_in[3] = c & d;

endmodule
