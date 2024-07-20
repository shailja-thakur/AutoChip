module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  assign out_both = in[99:1] & in[98:0];
  assign out_any = in[99:0] | in[98:1];
  
  wire [99:0] in_shifted;
  assign in_shifted[99] = in[98];
  assign in_shifted[98:0] = in[99:1];
  
  assign out_different = in ^ in_shifted;
  
endmodule
