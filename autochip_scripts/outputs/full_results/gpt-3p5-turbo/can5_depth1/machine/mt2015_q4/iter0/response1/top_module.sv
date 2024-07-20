module top_module(
	input x,
	input y,
	output reg z);
	
	wire a, b;

	and gate1(a, x, y);
	or gate2(b, x, y);
	and gate3(z, a, b);
endmodule
