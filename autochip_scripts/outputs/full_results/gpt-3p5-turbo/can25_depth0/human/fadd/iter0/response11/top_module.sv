module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Declare internal wire variables
  wire w1, w2, w3;

  // Define sum and cout signals
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
