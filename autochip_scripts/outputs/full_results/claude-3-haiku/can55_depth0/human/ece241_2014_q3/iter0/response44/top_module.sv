module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implement the logic for mux_in[3:0] using 2-to-1 multiplexers

    // Determine the values for mux_in[0], mux_in[1], mux_in[2], and mux_in[3]
    assign mux_in[0] = 1;
    assign mux_in[1] = c;
    assign mux_in[2] = c | d;
    assign mux_in[3] = c | d;

endmodule
