module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define mux inputs based on the Karnaugh map
    assign mux_in[0] = d;      // K-map: cd = 00 | 1, rest | 0
    assign mux_in[1] = ~c & ~d; // K-map: cd = 01 | ~c ~d = 1, rest | 0
    assign mux_in[2] = c;       // K-map: cd = 11 | c = 1, d = 1
    assign mux_in[3] = c | d;   // K-map: cd = 10 | c = 1, rest | d

endmodule
