module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Correcting assignments based on the provided Karnaugh map
    
    // ab = 00
    assign mux_in[0] = d;                               // When cd=00,01,11,10 -> d (d == 0 when 00, 11, 10)
    // ab = 01
    assign mux_in[1] = 0;                               // All cd are 0
    // ab = 10
    assign mux_in[2] = (~c & d) | (c & ~d);             // cd 10 -> cd 10, 10, 10
    // ab = 11
    assign mux_in[3] = (~c & d) | (c & d) | (~c & ~d);  // When cd=00,01,11,10 -> cd 10 (final)

endmodule
