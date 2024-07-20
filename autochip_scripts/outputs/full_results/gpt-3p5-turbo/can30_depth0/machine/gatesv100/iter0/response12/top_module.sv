module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
  // Generate out_both by performing a bit-wise AND operation between in and in shifted by 1 bit
  assign out_both = in[98:0] & in[99:1];
  
  // Generate out_any by performing a bit-wise OR operation between in and in shifted by 1 bit
  assign out_any = in | {in[99], in[98:0]};
  
  // Generate out_different by performing a bit-wise XOR operation between in and in shifted by 1 bit
  assign out_different = in ^ {in[99], in[98:0]};

endmodule
