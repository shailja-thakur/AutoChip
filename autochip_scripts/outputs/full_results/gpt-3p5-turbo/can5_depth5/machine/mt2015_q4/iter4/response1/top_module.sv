module top_module(
	input x,
	input y,
	output z);
	
	and gate1(g1_out, x, y);
	and gate2(g2_out, y, x);
	and gate3(z, g1_out, g2_out);
	
endmodule
