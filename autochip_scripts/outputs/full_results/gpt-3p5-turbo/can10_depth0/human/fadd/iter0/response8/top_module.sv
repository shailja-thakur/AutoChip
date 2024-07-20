module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Internal signals
  wire w1, w2, w3;

  // Instantiate the full adder
  full_adder fa1(.a(a), .b(b), .cin(cin), .c(w1), .s(w2));
  full_adder fa2(.a(w2), .b(w1), .cin(1'b0), .c(cout), .s(sum));

endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output c,
  output s
);

  xor_gate x1(.a(a), .b(b), .o(s1));
  and_gate a1(.a(a), .b(b), .o(c1));
  and_gate a2(.a(a), .b(cin), .o(c2));
  and_gate a3(.a(b), .b(cin), .o(c3));
  or_gate o1(.a(c1), .b(c2), .o(w1));
  or_gate o2(.a(w1), .b(c3), .o(c));

endmodule
module xor_gate (
  input a,
  input b,
  output o
);
  assign o = a ^ b;
endmodule
module and_gate (
  input a,
  input b,
  output o
);
  assign o = a & b;
endmodule
module or_gate (
  input a,
  input b,
  output o
);
  assign o = a | b;
endmodule
