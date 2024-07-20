module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
  
  wire and_temp;
  wire or_temp;
  wire [99:0] xor_temp;
  
  assign and_temp = &in;
  assign or_temp = |in;
  assign xor_temp = ^in;
  
  assign out_and = and_temp;
  assign out_or = or_temp;
  assign out_xor = xor_temp;
  
endmodule
