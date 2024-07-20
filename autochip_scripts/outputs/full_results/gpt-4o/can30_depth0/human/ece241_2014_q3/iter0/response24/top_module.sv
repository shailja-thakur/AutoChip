module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Karnaugh map
    //       ab
    // cd   00 01 11 10
    //  00 | 0 | 0 | 0 | 1 |
    //  01 | 1 | 0 | 0 | 0 |
    //  11 | 1 | 0 | 1 | 1 |
    //  10 | 1 | 0 | 0 | 1 |
    
    // Implementing the minterms
    assign mux_in[0] = (~c & ~d) | (c & ~d) | (c & d);   // (00, 01, 11)
    assign mux_in[1] = 1'b0;                             // No 01
    assign mux_in[2] = (c & d);                          // (11)
    assign mux_in[3] = (~c & d) | (c & d) | (c & ~d);    // (10, 11, 01)

endmodule
