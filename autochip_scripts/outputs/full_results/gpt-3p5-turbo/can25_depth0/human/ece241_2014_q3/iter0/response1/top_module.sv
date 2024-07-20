module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

wire [1:0] ab;
wire [1:0] cd;

assign ab = {c,d};
assign cd = {c,d};

wire [3:0] out;

assign out[0] = (~ab[1] & ~ab[0] & ~cd[1]) | (~ab[0] & ~cd[0]);
assign out[1] = (~ab[1] & ab[0] & ~cd[1]) | (~ab[1] & ~ab[0] & cd[1]);
assign out[2] = ab[1] | (~ab[1] & ~ab[0] & cd[1]) | ab[0];
assign out[3] = ab[1] | (~ab[1] & ab[0] & ~cd[1]) | (~ab[1] & ~ab[0] & ~cd[1]) | ab[0];

assign mux_in = out;

endmodule
