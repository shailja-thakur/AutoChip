module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = (c & ~d) | (~c & d) | (c & ~c & d & ~d); // ab=00: 1 when output 1
    assign mux_in[1] = (~c & d);                               // ab=01: 1 when (d)
    assign mux_in[2] = (c & d) | (~c & d);                     // ab=11: 1 when (c & d)
    assign mux_in[3] = (c & ~d) | (~c & ~d & (d & ~c));        // ab=10: 1 when (c)

endmodule
