module top_module (
  input in1,
  input in2,
  input in3,
  output logic out
);
  
  // XNOR gate
  assign {^in1, ^in2} = out;
  
  // XOR gate
  xor #2 u1(.a(out), .b(in3), .z(out));
  
endmodule
