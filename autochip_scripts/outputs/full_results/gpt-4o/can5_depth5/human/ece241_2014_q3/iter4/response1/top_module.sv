module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define mux inputs based on the Karnaugh map
    assign mux_in[0] = c & ~d | ~c & ~d; // 1 for (c,d) = 00, 10
    assign mux_in[1] = ~c & d;           // 1 for (c,d) = 01
    assign mux_in[2] = c & d;            // 1 for (c,d) = 11
    assign mux_in[3] = c & ~d | ~c & ~d; // 1 for (c,d) = 00, 10

endmodule
