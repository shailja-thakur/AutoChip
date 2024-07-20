module top_module(
  input a,
  input b,
  output out
);
  wire nor_out;
  
  // NOR gate implementation
  assign nor_out = ~(a | b);
  
  // Assign NOR output to the module output
  assign out = nor_out;
endmodule
