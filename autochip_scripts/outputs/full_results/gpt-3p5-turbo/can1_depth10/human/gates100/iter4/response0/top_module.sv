module top_module (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  assign out_and = &in;
  assign out_or = |in;

  wire [99:0] xor_input;
  assign xor_input = in ^ {100{1'b1}};
  assign out_xor = ^xor_input;

endmodule
