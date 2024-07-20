module top_module (
  input [2:0] in,
  output [1:0] out
);

  // Assign the output bits by adding the input bits
  assign out[0] = in[0] + in[1] + in[2];
  assign out[1] = out[0][2];

endmodule
