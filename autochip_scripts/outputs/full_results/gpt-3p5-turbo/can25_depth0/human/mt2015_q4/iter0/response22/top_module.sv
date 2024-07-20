module A (
  input x,
  input y,
  output z
);
  
  assign z = (~x & y) | (x & ~y);

endmodule
module B (
  input x,
  input y,
  output z
);
  
  assign z = (x & y) | (~x & ~y);

endmodule
module top_module(
	input x,
	input y,
	output z
);

  wire b1, b2, and_out, or_out;
  A a1(x, y, b1);
  B b1(x, y, b2);
  
  assign or_out = b1 | b2;
  assign and_out = b1 & b2;
  
  assign z = or_out ^ and_out;

endmodule
