module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = ~c & d;      // cd = 00 -> 4-to-1 mux input 0
    assign mux_in[1] = 0;           // cd = 01 -> 4-to-1 mux input 1
    assign mux_in[2] = (c & d) | (~c & d); // cd = 11 -> 4-to-1 mux input 2
    assign mux_in[3] = c | d;       // cd = 10 -> 4-to-1 mux input 3

endmodule
