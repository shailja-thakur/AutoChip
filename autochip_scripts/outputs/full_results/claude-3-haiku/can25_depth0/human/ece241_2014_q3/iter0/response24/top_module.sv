module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire cd_01, cd_11, cd_10;

assign mux_in[0] = 1'b1;
assign mux_in[1] = c;
assign mux_in[2] = d;
assign mux_in[3] = cd_10;

assign cd_01 = c & ~d;
assign cd_11 = c & d;
assign cd_10 = ~c & d;

endmodule
