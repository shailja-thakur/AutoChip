module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the provided Karnaugh map
    
    // cd = 00
    assign mux_in[0] = 1'b0;   // ab = 00: 0
    // cd = 01
    assign mux_in[1] = 1'b1;   // ab = 01: 1
    // cd = 11
    assign mux_in[3] = 1'b1;   // ab = 11: 1
    // cd = 10
    assign mux_in[2] = d;      // ab = 10: d

endmodule
