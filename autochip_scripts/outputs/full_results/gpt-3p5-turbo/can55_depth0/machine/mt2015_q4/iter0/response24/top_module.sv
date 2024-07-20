module gate(
  input a,
  input b,
  output gate_out
  );
  
  assign gate_out = a & b; // use AND gate for basic logic function
endmodule
module top_module(
  input x,
  input y,
  output z
  );

  wire a1, b1, a2, b2; // intermediate wires
  gate g1(.a(x), .b(y), .gate_out(a1)); // first gate
  gate g2(.a(y), .b(x), .gate_out(b1)); // second gate
  gate g3(.a(a1), .b(b1), .gate_out(z)); // third gate
endmodule
