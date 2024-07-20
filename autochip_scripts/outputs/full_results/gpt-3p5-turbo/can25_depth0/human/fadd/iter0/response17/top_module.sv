module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  
  // Declare internal signals
  wire s1, s2, c1, c2;
  
  // Instantiate the full adder submodule
  full_adder FA1 (
    .a(a),
    .b(b),
    .cin(cin),
    .cout(c1),
    .sum(s1)
  );
  
  full_adder FA2 (
    .a(s1),
    .b(cin),
    .cin(c1),
    .cout(c2),
    .sum(sum)
  );
  
  // Output signals
  assign cout = c2;
  
endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  
  wire s1, s2;
  
  // Calculate the sum
  assign s1 = a ^ b;
  assign sum = s1 ^ cin;
  
  // Calculate the carry-out
  assign s2 = a & b;
  assign cout = s2 | (s1 & cin);
  
endmodule
