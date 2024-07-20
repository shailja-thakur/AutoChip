module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
  
  // instantiate the full adder module
  full_adder fa1 (
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout),
    .sum(sum)
  );

endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  
  // wire declaration
  wire w1, w2, w3;
  
  // XOR gates
  xor_gate x1 (
    .a(a),
    .b(b),
    .out(w1)
  );
  
  xor_gate x2 (
    .a(w1),
    .b(cin),
    .out(sum)
  );
  
  // AND gates
  and_gate a1 (
    .a(a),
    .b(b),
    .out(w2)
  );
  
  and_gate a2 (
    .a(b),
    .b(cin),
    .out(w3)
  );
  
  and_gate a3 (
    .a(a),
    .b(cin),
    .out(w4)
  );
  
  // OR gate
  or_gate o1 (
    .a(w2),
    .b(w3),
    .out(cout)
  );
  
endmodule
module xor_gate (
  input a,
  input b,
  output out
);
  assign out = a ^ b;
endmodule
module and_gate (
  input a,
  input b,
  output out
);
  assign out = a & b;
endmodule
module or_gate (
  input a,
  input b,
  output out
);
  assign out = a | b;
endmodule
