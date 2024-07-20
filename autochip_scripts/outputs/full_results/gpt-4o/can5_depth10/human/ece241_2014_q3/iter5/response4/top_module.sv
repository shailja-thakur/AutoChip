module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map
    assign mux_in[0] = d;        // c d = 00 -> 1, 01 -> 1, 11 -> 1, 10 -> 1
    assign mux_in[1] = 1'b0;     // c d = 00 -> 0, 01 -> 0, 11 -> 0, 10 -> 0
    assign mux_in[2] = c;        // c d = 00 -> 0, 01 -> 0, 11 -> 1, 10 -> 1
    assign mux_in[3] = 1'b1;     // c d = 00 -> 1, 01 -> 1, 11 -> 1, 10 -> 1

endmodule
