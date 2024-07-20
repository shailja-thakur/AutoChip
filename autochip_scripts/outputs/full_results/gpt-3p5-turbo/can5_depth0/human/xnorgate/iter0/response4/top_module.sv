module top_module(
  input a,
  input b,
  output out
);
  
  /* Define internal wire for intermediate calculation */
  wire internal;
  
  /* Implement XNOR function using AND, OR, and NOT gates */
  assign internal = ~(a ^ b);
  
  /* Output the result */
  assign out = internal;

endmodule
