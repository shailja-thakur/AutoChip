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

  /* create internal wires */
  wire internal1, internal2, internal3, internal4;
  
  /* create AND gates */
  and gate1(internal1, p1a, p1b, p1c);
  and gate2(internal2, p1d, p1e, p1f);
  and gate3(internal3, p2a, p2b);
  and gate4(internal4, p2c, p2d);
  
  /* create OR gates */
  or gate5(p1y, internal1, internal2);
  or gate6(p2y, internal3, internal4);

endmodule
