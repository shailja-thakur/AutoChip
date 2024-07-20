module top_module(
    input x,
    input y,
    output z
);
  
  // Instantiate the gates
  and_gate u1 (
    .a(x),
    .b(y),
    .c(a)
  );
  
  or_gate u2 (
    .a(y),
    .b(x),
    .c(b)
  );
  
  xor_gate u3 (
    .a(a),
    .b(b),
    .c(z)
  );
  
endmodule
module and_gate(
  input a,
  input b,
  output c
);
  assign c = a & b;
endmodule
module or_gate(
  input a,
  input b,
  output c
);
  assign c = a | b;
endmodule
module xor_gate(
  input a,
  input b,
  output c
);
  assign c = a ^ b;
endmodule
