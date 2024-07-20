module top_module(
  input x,
  input y,
  output z
);
  
  wire a;
  wire b;

  // Use assign statement to correctly connect the wires
  assign a = x & y;
  assign b = y & x;

  // Instantiate the third gate and connect inputs a and b to wires a and b respectively
  and gate3(z, a, b);

endmodule
