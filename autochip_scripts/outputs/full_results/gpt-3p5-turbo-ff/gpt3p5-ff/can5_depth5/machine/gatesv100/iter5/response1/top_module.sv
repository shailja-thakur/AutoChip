module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
  assign out_both = in[98:0] & (in[99:1] << 1'b1);
  assign out_any = in | (in << 1'b1);
  assign out_different = {in[0] ^ in[99], in ^ (in << 1'b1)};
endmodule
