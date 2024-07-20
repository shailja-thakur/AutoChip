module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [3:0] mux_in_temp;
wire [3:2] a_temp;

and G1 (c, d, a_temp[0]);
not G2 (c, a_temp[1]);

assign mux_in_temp[0] = ~(a_temp[0] & a_temp[1]);
assign mux_in_temp[1] = ~(c & d);
assign mux_in_temp[2] = (a_temp[0] & a_temp[1]);
assign mux_in_temp[3] = ~(a_temp[0] & ~a_temp[1]);

demux_2to4 D1 (mux_in_temp[0], a, mux_in[0]);
demux_2to4 D2 (mux_in_temp[1], a, mux_in[1]);
demux_2to4 D3 (mux_in_temp[2], a, mux_in[2]);
demux_2to4 D4 (mux_in_temp[3], a, mux_in[3]);

endmodule
