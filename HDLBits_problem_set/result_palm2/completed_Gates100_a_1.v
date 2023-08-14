module top_module (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  wire [99:0] and_out;
  wire [99:0] or_out;
  wire [99:0] xor_out;

  // AND gate
  assign and_out = in & in;

  // OR gate
  assign or_out = in | in;

  // XOR gate
  assign xor_out = in ^ in;

  // Connect the outputs to the ports
  assign out_and = and_out;
  assign out_or = or_out;
  assign out_xor = xor_out;

endmodule