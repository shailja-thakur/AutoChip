module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implementing the truth table using the given Karnaugh map
    assign mux_in[0] = ~c & ~d; // For ab=00
    assign mux_in[1] = c & ~d;  // For ab=01
    assign mux_in[2] = c & d;   // For ab=11
    assign mux_in[3] = ~c & d;  // For ab=10

endmodule
