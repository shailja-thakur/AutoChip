module top_module (
  input a,
  input b,
  output sum,
  output cout
);

  // Logic for half adder
  assign sum = a ^ b;
  assign cout = a & b;

endmodule
