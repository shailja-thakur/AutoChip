module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  // Generate out_both signal by performing bitwise AND operation
  assign out_both = in[99:1] & in[98:0];

  // Generate out_any signal by performing bitwise OR operation
  assign out_any = in;

  // Generate out_different signal
  assign out_different = {in[99] ^ in[0], in[99:1] ^ in[98:0]};

endmodule
