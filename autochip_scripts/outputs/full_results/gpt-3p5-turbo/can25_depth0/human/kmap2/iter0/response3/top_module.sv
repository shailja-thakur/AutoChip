module top_module (
  input a,
  input b,
  input c,
  input d,
  output out
);

  // Define the internal wires for the circuit
  wire w1, w2, w3, w4;
  
  // Implement the circuit logic
  assign w1 = ~(a & b) & (c | d);
  assign w2 = (a | b) & (~c | d);
  assign w3 = c & (~a | ~b | d);
  assign w4 = (a & b) | (~c & ~d);
  
  // Connect the output
  assign out = w1 | w2 | w3 | w4;
  
endmodule
