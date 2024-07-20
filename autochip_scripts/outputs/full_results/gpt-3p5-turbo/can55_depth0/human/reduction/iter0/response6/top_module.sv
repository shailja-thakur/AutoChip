module top_module (
  input [7:0] in,
  output parity
);

  // variables
  wire [7:0] xor_out;

  // compute the XOR of all input bits
  assign xor_out = ^in;

  // compute the parity bit (even parity)
  assign parity = ^xor_out;
endmodule
