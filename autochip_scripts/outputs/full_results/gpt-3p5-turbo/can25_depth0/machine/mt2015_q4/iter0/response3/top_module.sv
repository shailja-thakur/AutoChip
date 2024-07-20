module top_module(
  input x,
  input y,
  output z);
  
  wire a, b;
  
  and gate1(a, x, y); // First gate: output is assigned to 'a' signal
  
  and gate2(b, y, x); // Second gate: output is assigned to 'b' signal
  
  and gate3(z, a, b); // Third gate: output is assigned to 'z' signal
  
endmodule
