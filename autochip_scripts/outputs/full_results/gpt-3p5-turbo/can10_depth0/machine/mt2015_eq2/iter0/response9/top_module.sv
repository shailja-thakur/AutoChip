module top_module(
  input [1:0] A,
  input [1:0] B,
  output z
);

  // Declare internal wire(s)
  wire [1:0] equal;

  // Compare the bits of A and B
  assign equal = (A == B);

  // Output z will be set to 1 if all the bits are equal and 0 otherwise
  assign z = (equal[0] && equal[1]);

endmodule
