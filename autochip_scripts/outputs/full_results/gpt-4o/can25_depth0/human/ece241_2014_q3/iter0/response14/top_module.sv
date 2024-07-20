module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = ( ~c & ~d);       // ab = 00: 0
    assign mux_in[1] = (  c & ~d);       // ab = 01: 0
    assign mux_in[2] = (  c &  d);       // ab = 11: 1
    assign mux_in[3] = ( ~c &  d);       // ab = 10: 1

endmodule
