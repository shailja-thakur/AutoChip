module top_module (
   input c,
   input d,
   output [3:0] mux_in
);

wire c0, c1, c2, c3;

and(c0, ~c, ~d);
and(c1, c, ~d);
and(c2, c, d);
and(c3, ~c, d);

assign mux_in[0] = c0;
assign mux_in[1] = c1;
assign mux_in[2] = c2;
assign mux_in[3] = c3;

endmodule
