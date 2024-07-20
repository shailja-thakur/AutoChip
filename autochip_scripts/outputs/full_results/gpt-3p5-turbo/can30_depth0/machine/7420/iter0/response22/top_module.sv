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
  
  wire p1_zero;
  wire p2_zero;
  
  and #(4) u1(p1_zero, p1a, p1b, p1c, p1d);
  and #(4) u2(p2_zero, p2a, p2b, p2c, p2d);
  
  not u3(p1y, p1_zero);
  not u4(p2y, p2_zero);
  
endmodule
