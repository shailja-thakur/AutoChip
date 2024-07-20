module top_module(
    input x,
    input y,
    output z);
  
  // XOR gate to compute x^y
  wire xor_output;
  xor xor_gate(x, y, xor_output);
  
  // AND gate to compute (x^y) & x
  wire and_output;
  and and_gate(xor_output, x, and_output);
  
  assign z = and_output;
  
endmodule
