module top_module (
  input [2:0] in,
  output [1:0] out
);

  assign out[1] = in[2] ^ in[1]; // out[1] is the XOR of in[2] and in[1]
  assign out[0] = in[1] & in[0]; // out[0] is the AND of in[1] and in[0]

endmodule
