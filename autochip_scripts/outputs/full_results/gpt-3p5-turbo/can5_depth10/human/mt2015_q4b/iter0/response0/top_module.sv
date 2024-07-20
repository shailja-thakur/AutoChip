module top_module(
  input x,
  input y,
  output z
);
  
  wire temp1, temp2;
  
  assign temp1 = x & ~y;
  assign temp2 = temp1 | z;
  assign z = temp2;
  
endmodule
