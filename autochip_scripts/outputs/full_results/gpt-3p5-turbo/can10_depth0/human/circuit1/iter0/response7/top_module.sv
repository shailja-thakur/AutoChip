module top_module (
  input a,
  input b,
  output q
);
  
  // Implementing the circuit
  assign q = a & ~b;
  
endmodule
