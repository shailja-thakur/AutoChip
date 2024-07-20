module top_module(
  input x,
  input y,
  output z);

  // Declare internal signals
  wire xor_result;
  wire or_result;

  // Calculate XOR of x and y
  xor (
    xor_result,
    x,
    y
  );

  // Calculate OR of x and y
  or (
    or_result,
    x,
    y
  );

  // Calculate the negation of xor_result
  not (
    z,
    xor_result
  );

endmodule
