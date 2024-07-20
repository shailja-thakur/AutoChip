module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = (~c & ~d) | (c & d) | (c & ~d);  // 00, 10, 11 -> 1
    assign mux_in[1] = 0;  // 01 -> 0
    assign mux_in[2] = (c & d);  // 11 -> 1
    assign mux_in[3] = (~c & d) | (~d);  // 00, 10, 11 -> 1

endmodule
