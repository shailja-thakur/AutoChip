module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire w0, w1, w2, w3, w4, w5, w6, w7;
wire x, y, z;

and gate1 (w0, c, d);
and gate2 (w1, c, d);
and gate3 (w2, c, d);
and gate4 (w3, c, d);
and gate5 (w4, c, d);
and gate6 (w5, c, d);
and gate7 (w6, c, d);
and gate8 (w7, c, d);

or gate9 (x, w1, w2, w3, w6);
or gate10 (y, w4, w5);
or gate11 (z, w3, w4, w7);

assign mux_in[0] = z;
assign mux_in[1] = y;
assign mux_in[2] = x;
assign mux_in[3] = w0;

endmodule
