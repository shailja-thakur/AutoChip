module top_module (
	input a,
	input b,
	input c,
	input d,
	output wire out,
	output wire out_n );

  wire w1, w2;
  
  assign w1 = a & b;
  assign w2 = c & d;
  
  assign out = w1 | w2;
  assign out_n = ~out;
  
endmodule
