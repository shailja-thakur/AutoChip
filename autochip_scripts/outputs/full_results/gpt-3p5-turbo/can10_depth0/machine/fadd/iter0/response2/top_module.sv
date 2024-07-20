module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Internal signals
  wire temp_sum;
  wire temp_carry;

  // Adder logic
  assign temp_sum = a ^ b ^ cin;
  assign temp_carry = (a & b) | (cin & (a ^ b));

  // Assign outputs
  assign sum = temp_sum;
  assign cout = temp_carry;

endmodule
