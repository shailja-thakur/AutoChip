module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  /* Specify the width of the internal signal */
  wire s, c1, c2;

  /* Instantiate the full adder */
  full_adder fa0 (.a(a), .b(b), .cin(cin), .sum(s), .cout(c1));
  full_adder fa1 (.a(s), .b(cin), .cin(c1), .sum(sum), .cout(c2));

  /* Assign the carry-out to the output */
  assign cout = c2;

endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  
  /* Implement the logic for sum */
  assign sum = a ^ b ^ cin;

  /* Implement the logic for carry-out */
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
