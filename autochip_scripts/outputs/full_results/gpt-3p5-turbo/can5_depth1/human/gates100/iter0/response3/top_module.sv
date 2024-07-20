module top_module (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);
  
  assign out_and = &in;
  assign out_or = |in;
  
  wire [99:0] temp_xor;
  assign temp_xor = ^in;
  assign out_xor = temp_xor[99];

endmodule
