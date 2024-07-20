module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  wire n1, n2, n3, n4, n5;

  assign n1 = ~b & ~c;
  assign n2 = a & ~d;
  assign n3 = n1 & n2;
  assign n4 = b & ~d;
  assign n5 = n3 | n4;
  assign q = ~n5;

endmodule
