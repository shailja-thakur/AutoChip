module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define the truth table values for mux inputs based on the given K-map
    assign mux_in[0] = ~c & ~d; // 00 -> 1
    assign mux_in[1] = ~c & d;  // 01 -> 0
    assign mux_in[2] = c & d;   // 11 -> 1
    assign mux_in[3] = c | ~d;  // 10 -> 1

endmodule
