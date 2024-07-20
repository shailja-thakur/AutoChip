module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  // Internal wires
  wire w1, w2, w3;

  // Instantiate the full adder
  full_adder fa1 (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(w1),
    .cout(w2)
  );

  // Instantiate the half adder
  half_adder ha1 (
    .a(w1),
    .b(cin),
    .sum(sum),
    .cout(w3)
  );

  // Connect the carry-out of the full adder to the carry-out of the top module
  assign cout = w2;

endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  // Internal wires
  wire w1, w2, w3;

  // XOR gate
  xor_gate x1 (
    .a(a),
    .b(b),
    .o(w1)
  );

  // XOR gate
  xor_gate x2 (
    .a(w1),
    .b(cin),
    .o(sum)
  );

  // AND gate
  and_gate a1 (
    .a(a),
    .b(b),
    .o(w2)
  );

  // AND gate
  and_gate a2 (
    .a(a),
    .b(cin),
    .o(w3)
  );

  // OR gate
  or_gate o1 (
    .a(w2),
    .b(w3),
    .o(cout)
  );

endmodule
module half_adder (
  input a,
  input b,
  output sum,
  output cout
);
  // XOR gate
  xor_gate x1 (
    .a(a),
    .b(b),
    .o(sum)
  );

  // AND gate
  and_gate a1 (
    .a(a),
    .b(b),
    .o(cout)
  );

  // Inverter gate
  inverter i1 (
    .a(sum),
    .o(cout)
  );

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
module inverter (
  input a,
  output o
);
  assign o = ~a;
endmodule
