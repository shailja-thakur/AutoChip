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

// Internal wires for intermediate signals
wire p1_w1, p1_w2, p2_w1, p2_w2;

// AND gates for p1y
and gate1(p1_w1, p1a, p1b);
and gate2(p1_w2, p1d, p1e);

// AND gate for p2y
and gate3(p2_w1, p2a, p2b);
and gate4(p2_w2, p2c, p2d);

// OR gates for p1y and p2y
or gate5(p1y, p1_w1, p1c);
or gate6(p2y, p2_w1, p2_w2);

endmodule
