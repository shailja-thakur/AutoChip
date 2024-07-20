module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values to mux_in based on Karnaugh map
    assign mux_in[0] = (~c & d) | (c & ~d); // 00 -> mux_in[0] = 0, K-map 2nd row 01 and 3rd row 11, both have output 1, simplified (c'd | cd')
    assign mux_in[1] = 0;                   // 01 -> mux_in[1] = 0 for all cases 
    assign mux_in[2] = c | (d & ~c);        // 11 -> mux_in[2] = 1, K-map 3rd row 11, all have output 1, hence c simplified version but 01 having 0 ((cd) | (~cd)  == c + d\c) => (1 0 0 1) == (d & ~c)
    assign mux_in[3] = 1;                   // 10 -> mux_in[3] = 1 for all cases

endmodule
