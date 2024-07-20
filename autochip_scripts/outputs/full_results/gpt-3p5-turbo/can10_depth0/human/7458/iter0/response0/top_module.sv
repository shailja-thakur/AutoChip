module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
	
	wire temp1, temp2;
	
	and gate1(temp1, p1a, p1b, p1c);
	and gate2(temp2, p1d, p1e, p1f);
	or gate3(p1y, temp1, temp2);
	
	and gate4(p2y, p2a, p2b);
	and gate5(p2y, p2c, p2d);
	
endmodule
