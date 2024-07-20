module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

  wire w1;
  wire w2;
  wire w3;
  wire w4;

  and and1(w1, a, b);
  or or1(w2, a, c);
  not not1(w3, d);
  or or2(w4, w2, w3);
  and and2(out, w1, w4);

endmodule
