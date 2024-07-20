module top_module(
  input x,
  input y,
  output z);

  // Declare internal signals
  wire a_internal;
  wire b_internal;

  // Instantiate gates
  and gate1(a_internal, y, x); // First gate with y as input a and x as input b
  and gate2(b_internal, x, y); // Second gate with x as input a and y as input b
  or gate3(z, a_internal, b_internal); // Third gate with a_internal as input a and b_internal as input b

endmodule
