module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assigning the values to mux_in according to the Karnaugh map
    assign mux_in[0] = (~c & ~d) | (c & d);
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = c | (~c & d);
    assign mux_in[3] = (~c & d) | (c & ~d) | c;

endmodule
