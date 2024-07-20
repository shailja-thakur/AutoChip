module top_module(
  input x,
  input y,
  output reg z);

  wire a, b;

  // First gate
  and_gate and1(.a=x, .b=y, .z=a);

  // Second gate
  and_gate and2(.a=y, .b=x, .z=b);

  // Third gate
  or_gate or1(.a=a, .b=b, .z=z);

endmodule
