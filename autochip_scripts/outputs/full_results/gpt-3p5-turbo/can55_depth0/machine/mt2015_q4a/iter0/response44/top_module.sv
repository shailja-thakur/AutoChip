module top_module(
  input x,
  input y,
  output z
);
  
  xor gate1(z, x, y); // XOR gate for x and y
  and gate2(z, z, x); // AND gate for XOR output and x
  
endmodule
