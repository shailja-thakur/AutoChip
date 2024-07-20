module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Correcting assignments based on the provided Karnaugh map
   
    // ab = 00
    assign mux_in[0] = (c & d) | (~c & d) | (c & ~d);   // When ab = 00, the output is 1 for cd = 10, 10, 10
    // ab = 01
    assign mux_in[1] = 0;                               // All cd are 0
    // ab = 10
    assign mux_in[2] = (~c & d) | c;                    // When ab = 10, the output is 1 for cd = 10, 10, 10 -> cd 10, cd=11, cd 11, cd 11
    // ab = 11
    assign mux_in[3] = c | d;                           // When ab = 11, the output is 1 for cd = 11, 11, 11

endmodule
