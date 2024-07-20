module top_module(
  input x,
  input y,
  output z);
  
  wire a, b, c;
  
  // First gate
  not u1(.a(x), .z(a));      // Using an inverter
  
  // Second gate
  not u2(.a(y), .z(b));      // Using an inverter
  
  // Third gate
  nor u3(.a(a), .b(b), .z(c));   // Using a NOR gate
  
  // Output
  assign z = c;
  
endmodule
