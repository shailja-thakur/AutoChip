module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire x1, x2, x3;

assign x1 = c | d;
assign x2 = ~c & d;
assign x3 = c & d;

assign mux_in[0] = x1;
assign mux_in[1] = 0;
assign mux_in[2] = x3;
assign mux_in[3] = x2;

endmodule
