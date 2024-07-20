module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    
    // Primary output assignments based on the Karnaugh map
    assign mux_in[0] = d | (~c & ~d);    // Covering cells 1, 5, 9, and 12
    assign mux_in[1] = 1'b0;             // Covering cells 2, 6, 10, and 14
    assign mux_in[2] = c & d;            // Covering cells 3, 7, 11, and 15
    assign mux_in[3] = c | (~c & d);     // Covering cells 4, 8, 12, and 16

endmodule
