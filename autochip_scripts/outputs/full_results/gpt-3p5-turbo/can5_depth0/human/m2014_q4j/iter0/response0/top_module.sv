module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

wire [3:0] carry;

// Full Adder module
// Implements the logic for a single full adder
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout 
);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (cin & (a ^ b));
endmodule
