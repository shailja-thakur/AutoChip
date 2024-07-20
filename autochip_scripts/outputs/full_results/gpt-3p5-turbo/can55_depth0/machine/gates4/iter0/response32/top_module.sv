module top_module (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  // Assign the out_and output to the logical AND operation on all bits of in
  assign out_and = in[0] & in[1] & in[2] & in[3];

  // Assign the out_or output to the logical OR operation on all bits of in
  assign out_or = in[0] | in[1] | in[2] | in[3];

  // Assign the out_xor output to the logical XOR operation on all bits of in
  assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];

endmodule
