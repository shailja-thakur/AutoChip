module top_module(
    input wire x,
    input wire y,
    output wire z);

  wire a, b;

  // First gate
  assign a = x & y;

  // Second gate
  assign b = x | y;

  // Third gate
  assign z = a ^ b;

endmodule
