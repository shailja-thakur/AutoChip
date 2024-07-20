module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire d_not, cd_not, cd;

not(d_not, d);
and(cd_not, c, d_not);
and(cd, c, d);

assign mux_in[0] = 1;
assign mux_in[1] = cd_not;
assign mux_in[2] = cd;
assign mux_in[3] = cd;

endmodule
