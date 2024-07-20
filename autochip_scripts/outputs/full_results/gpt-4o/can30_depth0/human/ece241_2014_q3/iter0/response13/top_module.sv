module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Mux inputs derived from the Karnaugh map
    assign mux_in[0] = (~c & d) | (c & d) | (~c & ~d); // 1 at cd = 00, 01, 11, 10
    assign mux_in[1] = 1'b0;                          // 0 at cd = 00, 01, 11, 10
    assign mux_in[2] = (c & d) | (~c & ~d);           // 1 at cd = 11, 10
    assign mux_in[3] = (~c & ~d) | (c & d);           // 1 at cd = 00, 10, 11

endmodule
