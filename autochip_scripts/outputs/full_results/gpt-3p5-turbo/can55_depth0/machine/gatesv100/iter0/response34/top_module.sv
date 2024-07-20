module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  reg [99:0] shifted_in;
  
  assign shifted_in = {in[98:0], in[99]};
  
  assign out_both = in & shifted_in;
  assign out_any = in | shifted_in;
  assign out_different = {in[0] ^ in[99], in ^ shifted_in};
  
endmodule
