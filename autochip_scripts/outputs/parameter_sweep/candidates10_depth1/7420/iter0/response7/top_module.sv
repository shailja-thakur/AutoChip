module top_module(
	input [7:0] p1, 
	output p1y, 
	input [7:0] p2, 
	output p2y
);
	// Gate 1
	wire g1a, g1b, g1c, g1d, g1y;
	
	assign g1a = p1[0] & p1[1] & p1[2] & p1[3];
	assign g1b = p1[4] & p1[5] & p1[6] & p1[7];
	
	and gate1(g1a, g1b, g1c, g1d, g1y);
	
	// Gate 2
	wire g2a, g2b, g2c, g2d, g2y;
	
	assign g2a = p2[0] & p2[1] & p2[2] & p2[3];
	assign g2b = p2[4] & p2[5] & p2[6] & p2[7];
	
	and gate2(g2a, g2b, g2c, g2d, g2y);
	
	assign p1y = g1y;
	assign p2y = g2y;
endmodule
module and(
	input a,
	input b,
	input c,
	input d,
	output y
);
	assign y = ~(a & b & c & d);
endmodule
