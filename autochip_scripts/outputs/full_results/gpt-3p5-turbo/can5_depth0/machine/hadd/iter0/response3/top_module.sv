module top_module (
  input a,
  input b,
  output sum,
  output cout
);

  // Logic to add the inputs a and b
  assign sum = a + b;
  assign cout = a & b;

endmodule
