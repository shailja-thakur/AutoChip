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

wire and1_output;
wire and2_output;

and and1 (and1_output, p1a, p1b, p1c, p1d);
and and2 (and2_output, p2a, p2b, p2c, p2d);

not not1 (p1y, and1_output);
not not2 (p2y, and2_output);

endmodule
