module top_module(
  input wire x,
  input wire y,
  output wire z);

  wire a, b;

  // First gate
  and gate1(a, x, y);

  // Second gate
  and gate2(b, y, x);

  // Third gate
  or gate3(z, a, b);

endmodule
