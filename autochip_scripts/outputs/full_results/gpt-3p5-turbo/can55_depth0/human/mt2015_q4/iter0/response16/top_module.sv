module A(
	input x,
  input y,
  output z);
  
  assign z = (x^y) & x;
endmodule
module B(
  input x,
  input y,
  output z);
  
  assign #5 z = (x | y) & x;
endmodule
module top_module(
	input x,
	input y,
	output z);
  
  wire a_out1, b_out1, a_out2, b_out2;
  wire a1_or_b1, a2_and_b2;
  
  A a1(x, y, a_out1);
  B b1(x, y, b_out1);
  A a2(x, y, a_out2);
  B b2(x, y, b_out2);
  
  assign a1_or_b1 = a_out1 | b_out1;
  assign a2_and_b2 = a_out2 & b_out2;
  
  assign z = a1_or_b1 ^ a2_and_b2;
  
endmodule
