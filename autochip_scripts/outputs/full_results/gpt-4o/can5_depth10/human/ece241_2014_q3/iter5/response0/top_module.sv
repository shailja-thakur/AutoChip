module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Correct value assignments based on the Karnaugh map
    
    // ab = 00 values for cd
    assign mux_in[0] = (d & ~c) | c;   // When ab = 00: 00 -> 0, 01 -> 1, 11 -> 1, 10 -> 1
    
    // ab = 01 values for cd
    assign mux_in[1] = 0;  // All values are 0

    // ab = 11 values for cd
    assign mux_in[3] = c & d;  // When ab = 11: 00 -> 0, 01 -> 0, 11 -> 1, 10 -> 0

    // ab = 10 values for cd
    assign mux_in[2] = ~c | d;  // When ab = 10: 00 -> 1, 01 -> 0, 11 -> 1, 10 -> 1

endmodule
