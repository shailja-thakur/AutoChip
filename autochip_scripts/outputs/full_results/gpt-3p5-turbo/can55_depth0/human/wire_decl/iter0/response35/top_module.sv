module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );
	
	wire intermediate_w1;
	wire intermediate_w2;
	
	and gate1 (a, b, intermediate_w1);
	and gate2 (c, d, intermediate_w2);
	or gate3 (intermediate_w1, intermediate_w2, out);
	not gate4 (out, out_n);
	
endmodule
