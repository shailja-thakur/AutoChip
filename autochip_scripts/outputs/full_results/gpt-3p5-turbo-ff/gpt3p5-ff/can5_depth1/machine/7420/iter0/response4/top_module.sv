module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
	// AND gates for p1y
	and u1(p1a, p1b, p1c, p1d, p1y);
	
	// AND gates for p2y
	and u2(p2a, p2b, p2c, p2d, p2y);
	
endmodule
module and(
  input a,
  input b,
  input c,
  input d,
  output y
);
  
  wire temp;
  
  and g1(a, b, temp);
  and g2(temp, c, y);
  and g3(y, d, y);
  
endmodule
