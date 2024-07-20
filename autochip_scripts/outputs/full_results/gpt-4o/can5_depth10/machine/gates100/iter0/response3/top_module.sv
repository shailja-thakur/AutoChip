module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

  // Initialize the result of AND operation to 1 (true) since AND of all bits requires starting with 1
  assign out_and = &in;

  // Initialize the result of OR operation to 0 (false) since OR of all bits requires starting with 0
  assign out_or = |in;

  // Initialize the result of XOR operation to 0
  assign out_xor = ^in;

endmodule
