module top_module(
  input wire x,
  input wire y,
  output wire z);
  
  wire a, b;

  // Logic gates
  assign a = x & ~y;
  assign b = ~x & y;
  assign z = a | b;

endmodule
