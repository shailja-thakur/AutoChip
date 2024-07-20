module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  // Generate out_both signal by performing bit-wise AND operation
  assign out_both = in[98:0] & in[99:1];

  // Generate out_any signal by performing bit-wise OR operation
  assign out_any = in | (in << 1);

  // Generate out_different signal by performing bit-wise XOR operation
  assign out_different = {in[0] ^ in[99], in ^ (in << 1)};

endmodule
