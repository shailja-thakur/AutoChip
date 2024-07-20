module top_module(
  input a,
  input b,
  output out
);

  // Instantiate the NOR gate
  assign out = ~(a | b);
  
endmodule
