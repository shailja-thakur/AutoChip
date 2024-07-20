module top_module(
  input x,
  input y,
  output z);

  // Internal wire for interconnecting the gates
  wire w1;
  
  // XOR gate to compute x^y
  xor gate1(w1,x,y);
  
  // AND gate to compute (x^y) & x
  and gate2(z,w1,x);

endmodule
