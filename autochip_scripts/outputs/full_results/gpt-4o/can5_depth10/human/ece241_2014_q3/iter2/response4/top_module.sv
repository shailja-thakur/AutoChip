module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Correcting assignments based on the provided Karnaugh map
    
    // ab = 00, when cd=00,01,11,10 -> mux_in[0] should be 1 when d is 1
    assign mux_in[0] = (c & d) | (~c & ~d);

    // ab = 01, all outputs are 0
    assign mux_in[1] = 0;

    // ab = 10, when cd=00,01,11,10 -> mux_in[2] should be 1 when c or d is 1
    assign mux_in[2] = (c & ~d) | (~c & d) | (c & d);
    
    // ab = 11, when cd=00,01,11,10 -> mux_in[3] should be 1 when either c or d is 1
    assign mux_in[3] = 1;

endmodule
