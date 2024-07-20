module top_module (
  input [7:0] in,
  output parity
);

  // Wire to hold the intermediate XOR result
  wire xor_result;

  // Calculate the XOR of all the input bits
  assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

  // The parity bit is the result of the XOR calculation
  assign parity = xor_result;

endmodule
