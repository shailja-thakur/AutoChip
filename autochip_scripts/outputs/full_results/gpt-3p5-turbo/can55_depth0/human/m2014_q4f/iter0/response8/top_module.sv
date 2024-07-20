module top_module (
  input in1,
  input in2,
  output logic out
);
  
  assign in2 = ~in2; // invert the in2 signal
  
  assign out = in1 & in2; // connect the inverted in2 to the AND gate
  
endmodule
