module top_module(
  input x,
  input y,
  output z);
  
  assign z = (x & y); // performing bitwise AND operation between x and y
  
endmodule
