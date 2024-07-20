module top_module(
  input x,
  input y,
  output z);
  
  wire a1, b1, a2, b2;
  
  and gate1(.a = x, .b = y, .z = a1);
  and gate2(.a = y, .b = x, .z = b1);
  or gate3(.a = a1, .b = b1, .z = a2);
  or gate4(.a = b1, .b = a1, .z = b2);
  or gate5(.a = a2, .b = b2, .z = z);
  
endmodule
