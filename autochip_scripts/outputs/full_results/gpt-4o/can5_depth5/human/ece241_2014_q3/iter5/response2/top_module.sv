module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define mux inputs based on the Karnaugh map
    assign mux_in[0] = d;          // ab = 00 -> K-map: 0101 (cd= 00, 01, 11, 10)
    assign mux_in[1] = 1'b0;       // ab = 01 -> K-map: 0000
    assign mux_in[2] = c | d;      // ab = 11 -> K-map: 0011 (cd= 00, 01, 11, 10)
    assign mux_in[3] = 1'b1;       // ab = 10 -> K-map: 1011 (cd= 00, 01, 11, 10)

endmodule
