module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define mux inputs based on the Karnaugh map
    assign mux_in[0] = c & d;  // 1 for (c,d) = 11
    assign mux_in[1] = ~c & ~d; // 1 for (c,d) = 00
    assign mux_in[2] = c;      // 1 for (c,d) = 10, 11
    assign mux_in[3] = 1'b1;   // always 1

endmodule
