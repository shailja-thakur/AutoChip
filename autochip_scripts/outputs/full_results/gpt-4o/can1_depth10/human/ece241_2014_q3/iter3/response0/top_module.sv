module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = d;                // Corresponds to cd=00 -> 1 when d=1 (irrespective of c)
    assign mux_in[1] = 0;                // Corresponds to cd=01 -> always 0
    assign mux_in[2] = c & d | ~c & ~d;  // Corresponds to cd=11 -> c and d
    assign mux_in[3] = 1;                // Corresponds to cd=10 -> always 1

endmodule
