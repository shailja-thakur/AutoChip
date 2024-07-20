module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  wire xor_output;
  wire inverted_output;

  assign xor_output = a ^ b ^ c ^ d;
  assign inverted_output = ~xor_output;
  assign q = inverted_output;

endmodule
