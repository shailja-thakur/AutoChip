module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

  wire w1, w2;

  and gate_1(w1, a, b);
  and gate_2(w2, c, d);
  or gate_3(out, w1, w2);
  not gate_4(out_n, out);
  
endmodule
