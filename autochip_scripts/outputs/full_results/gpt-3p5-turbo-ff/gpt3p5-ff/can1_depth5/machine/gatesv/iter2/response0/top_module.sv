module top_module (
  input [3:0] in,
  output [2:0] out_both,
  output [5:0] out_any,
  output [3:0] out_different
);

  assign out_both = in[2:0] & in[3:1];
  assign out_any = {in[2:0], 2'b00} | in[3:1];
  assign out_different = in ^ (in[3:1] << 1'b1);

endmodule
