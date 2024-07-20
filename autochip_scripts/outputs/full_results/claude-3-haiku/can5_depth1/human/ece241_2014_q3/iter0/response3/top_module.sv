module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire or1, or2, mux2_out;

assign mux_in[0] = 1'b1;
assign mux_in[1] = c;
assign or1 = c | d;
assign or2 = d;
assign mux2_out = (c) ? or1 : or2;
assign mux_in[2] = mux2_out;
assign mux_in[3] = 1'b1;

endmodule
