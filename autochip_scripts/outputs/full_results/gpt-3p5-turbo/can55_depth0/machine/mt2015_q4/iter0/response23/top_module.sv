module top_module(
  input x,
  input y,
  output z);
  
  wire a, b;
  
  // define gates
  not u1 (.a(x), .z(a));
  not u2 (.a(y), .z(b));
  and u3 (.a=a, .b=b, .z=z);
  
endmodule
