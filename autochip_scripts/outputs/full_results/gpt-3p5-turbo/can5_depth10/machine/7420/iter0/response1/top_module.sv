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

  wire and1_out, and2_out;
  
  and and1(and1_out, p1a, p1b, p1c, p1d);
  and and2(and2_out, p2a, p2b, p2c, p2d);
  
  // invert the outputs
  not not1(p1y, and1_out);
  not not2(p2y, and2_out);
  
endmodule
