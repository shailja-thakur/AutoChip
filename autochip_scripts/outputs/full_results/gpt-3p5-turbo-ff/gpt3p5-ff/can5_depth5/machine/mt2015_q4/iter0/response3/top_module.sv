module top_module(
  input wire x,
  input wire y,
  output wire z);

  wire a, b;

  // First gate
  or_gate gate1(x, y, a);

  // Second gate
  or_gate gate2(y, x, b);

  // Third gate
  or_gate gate3(a, b, z);

endmodule
