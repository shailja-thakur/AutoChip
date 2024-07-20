module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

  // out_both
  assign out_both = {in[98:0], 1'b0} & in;
  
  // out_any
  assign out_any = in | {1'b0, in[99:1]};
  
  // out_different
  assign out_different = in ^ {in[99], in[98:0]};

endmodule
