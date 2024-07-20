module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assigning values to mux_in based on the Karnaugh map
    assign mux_in[0] = d;              // ab = 00
    assign mux_in[1] = 1'b0;           // ab = 01
    assign mux_in[2] = 1'b1;           // ab = 11
    assign mux_in[3] = ~d | c;         // ab = 10

endmodule
