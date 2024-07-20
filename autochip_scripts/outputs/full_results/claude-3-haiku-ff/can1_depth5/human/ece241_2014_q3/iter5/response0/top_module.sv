module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // 2-to-1 mux1
    assign mux_in[0] = d;
    assign mux_in[1] = ~d;

    // 2-to-1 mux2
    assign mux_in[2] = (c & ~d) | (~c & d);
    assign mux_in[3] = (c & d) | (~c & ~d);

endmodule
