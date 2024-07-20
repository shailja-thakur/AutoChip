module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Calculate the values for the Karnaugh map directly
    assign mux_in[0] = ~c & d | c & ~d | c & d;  // a = 0, b = 0
    assign mux_in[1] = 0;                       // a = 0, b = 1
    assign mux_in[2] = c | ~c & d;              // a = 1, b = 1
    assign mux_in[3] = (c | d) & d;             // a = 1, b = 0

endmodule
