module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  // Wire declaration
  wire q_temp;

  // Logic gate implementation
  or gate1 (q_temp, b, c);

  // Assigning output
  assign q = q_temp;

endmodule
