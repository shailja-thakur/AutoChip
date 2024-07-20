module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assigning the values based on the Karnaugh map
    assign mux_in[0] = (c & d) | (~c & d) | (c & ~d); // Corresponding to ab = 00
    assign mux_in[1] = 1'b0; // Corresponding to ab = 01
    assign mux_in[2] = (c & ~d) | (c & d) | (~c & d); // Corresponding to ab = 11
    assign mux_in[3] = ~d; // Corresponding to ab = 10

endmodule
