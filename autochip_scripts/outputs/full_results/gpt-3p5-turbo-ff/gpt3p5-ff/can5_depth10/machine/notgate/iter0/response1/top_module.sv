module top_module(
  input wire in,
  output wire out
);
    
  // Logic to invert the input
  assign out = ~in;

endmodule
