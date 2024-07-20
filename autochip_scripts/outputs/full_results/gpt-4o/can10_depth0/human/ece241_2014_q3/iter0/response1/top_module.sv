module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values to mux_in based on the Karnaugh map
    assign mux_in[0] = (~c & d) | (c & ~d); // ab = 00
    assign mux_in[1] = 1'b0;                // ab = 01
    assign mux_in[2] = (c & d);             // ab = 11
    assign mux_in[3] = (~c & ~d) | (c & d); // ab = 10

endmodule
