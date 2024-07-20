module top_module (
  input x,
  input y,
  output z
);

  wire xor_output;
  wire or_output;

  xor(x, y, xor_output);
  or(x, y, or_output);
  and(or_output, x, z);

endmodule
