module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire ab_00, ab_01, ab_11, ab_10;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign ab_00 = 1;
    assign ab_01 = c;
    assign ab_11 = c | d;
    assign ab_10 = c | d;

    // Connect the 2-to-1 mux outputs to the 4-to-1 mux inputs
    assign mux_in[0] = ab_00;
    assign mux_in[1] = ab_01;
    assign mux_in[2] = ab_11;
    assign mux_in[3] = ab_10;

endmodule
