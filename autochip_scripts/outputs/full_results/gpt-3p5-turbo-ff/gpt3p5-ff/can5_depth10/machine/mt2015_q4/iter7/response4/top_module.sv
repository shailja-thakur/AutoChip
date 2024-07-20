module top_module(
  input x,
  input y,
  output z);

  wire a, b, c;

  // First gate
  and gate1(a, x, y);     // a = x AND y

  // Second gate
  not gate2_not(x_not, x);   // x_not = NOT x
  not gate2_not(y_not, y);   // y_not = NOT y
  or gate2(or_out, x_not, y_not);   // or_out = x_not OR y_not
  not gate2(b, or_out);    // b = NOT (x_not OR y_not)

  // Third gate
  or gate3(z, a, b);      // z = a OR b

endmodule
