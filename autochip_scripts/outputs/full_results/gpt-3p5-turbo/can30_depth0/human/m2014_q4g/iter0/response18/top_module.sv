module top_module (
  input in1,
  input in2,
  input in3,
  output logic out
);

  // Implementing the XNOR gate
  assign out_xnor = ~(in1 ^ in2);
  
  // Implementing the XOR gate
  assign out = out_xnor ^ in3;

endmodule
