module top_module(
	input x,
	input y,
	output z);
	
	wire a1, b1, a2, b2;
	
	and gate1(a1, x, y);
	and gate2(b1, y, x);
	and gate3(z, a1, b1);
	
endmodule
