module top_module (
  input in1,
  input in2,
  input in3,
  output logic out
);
  // XNOR gate implementation
  assign out1 = in1 ^ in2;
  
  // XOR gate implementation
  assign out = out1 ^ in3;
endmodule
