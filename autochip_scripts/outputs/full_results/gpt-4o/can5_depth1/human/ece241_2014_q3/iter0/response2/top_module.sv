module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = (~c & ~d);    // when ab = 00
    assign mux_in[1] = 1'b0;         // when ab = 01
    assign mux_in[2] = (c & d);      // when ab = 11
    assign mux_in[3] = (c | ~d);     // when ab = 10

endmodule
