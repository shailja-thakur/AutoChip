module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = ~c | d;  // 1 when (c,d) = (0,0), (0,1), (1,0)
    assign mux_in[1] = ~c & ~d; // 1 when (c,d) = (0,0)
    assign mux_in[2] = c & d;   // 1 when (c,d) = (1,1)
    assign mux_in[3] = 1'b1;    // always 1

endmodule
