module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Internal signals
  wire s1, c1, c2;

  // Instantiate the full adder component
  full_adder FA1(.a(a), .b(b), .cin(cin), .sum(s1), .cout(c1));
  full_adder FA2(.a(s1), .b(cin), .cin(c1), .sum(sum), .cout(c2));

  // Assign the carry-out signal
  assign cout = c2;

endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  wire s1, c1, c2;

  // XOR gates for sum and carry-out
  xor_gate XOR1(.a(a), .b(b), .z(s1));
  xor_gate XOR2(.a(s1), .b(cin), .z(sum));

  // AND gates for carry-in and carry-out
  and_gate AND1(.a(a), .b(b), .z(c1));
  and_gate AND2(.a(s1), .b(cin), .z(c2));

  // OR gate for final carry-out
  or_gate OR1(.a(c1), .b(c2), .z(cout));
 
endmodule
