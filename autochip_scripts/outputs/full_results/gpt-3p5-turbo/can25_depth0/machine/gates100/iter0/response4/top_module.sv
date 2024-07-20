module top_module (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  wire [99:0] and_inputs;
  wire [99:0] or_inputs;
  wire [99:0] xor_inputs;
  
  assign and_inputs = in;
  assign or_inputs = in;
  assign xor_inputs = in;
  
  assign out_and = &and_inputs;
  assign out_or = |or_inputs;
  assign out_xor = ^xor_inputs;
  
endmodule
