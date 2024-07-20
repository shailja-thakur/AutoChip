module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
  // Circuit Implementation
  wire w1, w2, w3;
  
  and gate1 (w1, a, b);
  xor gate2 (w2, c, d);
  or gate3 (w3, w1, w2);
  
  assign out = w3;
  
endmodule
