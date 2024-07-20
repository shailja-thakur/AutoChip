module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  wire [3:0] carry;
  wire [3:0] sum_bits;

  // Instantiate four full adders for each bit
  full_adder fa0(.a(x[0]), .b(y[0]), .cin(0), .sum(sum_bits[0]), .cout(carry[0]));
  full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum_bits[1]), .cout(carry[1]));
  full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum_bits[2]), .cout(carry[2]));
  full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum_bits[3]), .cout(carry[3]));

  // Connect the carry-out of the last full adder to the overflow bit
  assign sum[4] = carry[3];

  // Assign the sum bits
  assign sum[3:0] = sum_bits;

endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);

  assign {cout, sum} = a + b + cin;

endmodule
