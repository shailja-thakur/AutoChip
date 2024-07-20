module top_module (
  input in1,
  input in2,
  output logic out
);
  
  // AND gate implementation with bubble input
  assign out = in1 & ~in2;
  
endmodule
