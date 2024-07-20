module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map

    // ab = 00
    assign mux_in[0] = d;

    // ab = 01
    assign mux_in[1] = ~c & d;

    // ab = 11
    assign mux_in[3] = c | d;

    // ab = 10
    assign mux_in[2] = 1;

endmodule
