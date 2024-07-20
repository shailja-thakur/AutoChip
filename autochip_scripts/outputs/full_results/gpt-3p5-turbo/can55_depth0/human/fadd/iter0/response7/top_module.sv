module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Declare internal signals
  wire w1, w2, w3;

  // Connect inputs and outputs to internal signals
  assign w1 = a ^ b;
  assign sum = w1 ^ cin;
  assign cout = (a & b) | (w1 & cin);

endmodule
