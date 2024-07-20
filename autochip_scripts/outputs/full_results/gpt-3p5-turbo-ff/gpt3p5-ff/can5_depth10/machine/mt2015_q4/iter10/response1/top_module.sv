module top_module(
  input x,
  input y,
  output z);

  wire a, b;

  // First gate
  assign a = x & y;     // a = x AND y

  // Second gate
  assign b = x | y;      // b = x OR y

  // Third gate
  assign z = b;           // z = b

endmodule
