module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire t1, t2, t3;

assign t1 = ~c & ~d;
assign t2 = c & ~d;
assign t3 = c & d;

assign mux_in[0] = t1;
assign mux_in[1] = t2;
assign mux_in[2] = t3;
assign mux_in[3] = ~c & d;

endmodule
