module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Correct assignments based on the provided Karnaugh map

    // ab = 00
    assign mux_in[0] = d;              // When ab=00, outputs are row 00 -> 0, 0, 0, 1 (d in 1st col equals d)
    
    // ab = 01
    assign mux_in[1] = 0;              // When ab=01, outputs are row 01 -> 1, 0, 0, 0 (always 0 as per K-map)
    
    // ab = 11
    assign mux_in[2] = c;              // When ab=10, outputs are row 11 -> 1, 0, 1, 1 (1's in col 2 are by using c)
    
    // ab = 10
    assign mux_in[3] = 1;              // When ab=10, outputs are row 10 -> 1, 0, 0, 1 (always 1 as per K-map)

endmodule
