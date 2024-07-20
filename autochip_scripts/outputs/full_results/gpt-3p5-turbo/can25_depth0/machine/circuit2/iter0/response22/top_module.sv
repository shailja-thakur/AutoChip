module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  wire wire1, wire2, wire3;
  
  xor_gate X1(.a(a), .b(b), .o(wire1));
  xor_gate X2(.a(c), .b(d), .o(wire2));
  xor_gate X3(.a(wire1), .b(wire2), .o(wire3));
  not_gate N1(.a(wire3), .o(q));
  
endmodule
