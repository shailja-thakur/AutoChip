module top_module (
  input a, 
  input b,
  input c,
  input d,
  output out
);

wire n1, n2, n3, n4, n5, n6, n7, n8;
and #(4) and1(a, b, c, d, n1);
and #(4) and2(~a, ~b, c, ~d, n2);
and #(4) and3(~a, ~b, c, d, n3);
and #(4) and4(~a, b, ~c, d, n4);
and #(4) and5(a, ~b, ~c, ~d, n5);
and #(4) and6(a, ~b, c, ~d, n6);
and #(4) and7(a, b, ~c, ~d, n7);
and #(4) and8(a, b, c, d, n8);
or #(8) or1(n1, n2, n3, n4, n5, n6, n7, n8, out);

endmodule
