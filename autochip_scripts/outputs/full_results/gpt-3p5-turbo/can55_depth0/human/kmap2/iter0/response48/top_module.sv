module top_module (
  input a, 
  input b,
  input c,
  input d,
  output out
);

  // Intermediate wire variables to represent the input combinations
  wire w1, w2, w3;

  // Implement the logic equations derived from the Karnaugh map
  assign w1 = (a & b & ~c & ~d) | (a & ~b & d);
  assign w2 = (a & b & ~c & d) | (a & b & c & d) | (~a & b & c & ~d) | (~a & ~b & c & d);
  assign w3 = (a & ~b & c & ~d) | (~a & b & ~c & d) | (~a & b & c & ~d) | (~a & ~b & c & d);

  // Implement the output logic
  assign out = w1 | w2 | w3;

endmodule
